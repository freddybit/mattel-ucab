import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataTablesModule } from 'angular-datatables';
import { FormsModule } from '@angular/forms';
import { SupabaseService } from '../services/supabase.service';
import { Subject } from 'rxjs';

export interface Role {
  id: number;
  name: string;
  description: string;
  icon: string;
  permsCount: number;
}

export interface Permiso {
  idPermiso: number;
  nombre: string;
}

@Component({
  selector: 'app-seguridad',
  standalone: true,
  imports: [CommonModule, DataTablesModule, FormsModule],
  templateUrl: './seguridad.html',
  styleUrls: ['./seguridad.css'],
})
export class Seguridad implements OnInit, OnDestroy {
  public roles: Role[] = [];
  public cargando: boolean = true;

  // --- VARIABLES DE MODALES ---
  public modalOpen = false;
  public transferModalOpen = false;

  // --- VARIABLES DE BORRADO (TRANSFERENCIA) ---
  public roleToDelete: Role | null = null;
  public lifeguardRoleId: number | null = null;

  // --- VARIABLES DEL NUEVO ROL ---
  public roleForm = { name: '', description: '' };
  public permisosBase: Permiso[] = [];
  public permisosFiltrados: Permiso[] = [];
  public permisosSeleccionados: Permiso[] = [];
  public textoBusqueda: string = '';

  // --- VARIABLES DE DATATABLES ---
  public dtOptions: any = {};
  public dtTrigger: Subject<any> = new Subject<any>();

  constructor(
    private supabaseService: SupabaseService,
    private cdr: ChangeDetectorRef,
  ) {}

  async ngOnInit() {
    this.dtOptions = {
      destroy: true,
      pagingType: 'full_numbers',
      pageLength: 10,
      processing: true,
      language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
    };

    await this.cargarDatosIniciales();
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  async cargarDatosIniciales() {
    this.cargando = true;
    this.cdr.detectChanges();

    // 1. Cargamos el catálogo de permisos en minúsculas (Evita error 400)
    const { data: permsData, error: permsError } = await this.supabaseService.client
      .from('permiso')
      .select('idpermiso, nombre')
      .order('nombre', { ascending: true });

    if (permsData && !permsError) {
      this.permisosBase = permsData.map((p: any) => ({
        idPermiso: Number(p.idpermiso),
        nombre: p.nombre,
      }));
      this.permisosFiltrados = [...this.permisosBase];
    }

    // 2. Cargamos los roles reales y cruzamos con RolPermiso para contar sus permisos
    const { data: rolesData, error: rolesError } = await this.supabaseService.client
      .from('rol')
      .select('idrol, nombre, descripcion');

    const { data: rpData } = await this.supabaseService.client
      .from('rolpermiso')
      .select('rol_idrol');

    if (rolesData && !rolesError) {
      this.roles = rolesData.map((r: any) => {
        const idActual = Number(r.idrol);
        // Contamos cuántas veces aparece este idrol en la tabla asociativa
        const count = rpData
          ? rpData.filter((rp: any) => Number(rp.rol_idrol) === idActual).length
          : 0;

        return {
          id: idActual,
          name: r.nombre,
          description: r.descripcion || 'Sin descripción',
          icon: 'shield_person',
          permsCount: count,
        };
      });
    }

    this.cargando = false;

    // FORZADO DE RENDERIZADO: Despertamos a Angular y acoplamos DataTables
    this.cdr.detectChanges();
    setTimeout(() => {
      this.dtTrigger.next(null);
      this.cdr.detectChanges();
    }, 50);
  }

  // --- LÓGICA DE ETIQUETAS (TAGS) ---
  filtrarPermisos() {
    const q = this.textoBusqueda.toLowerCase();
    this.permisosFiltrados = this.permisosBase.filter((p) => p.nombre.toLowerCase().includes(q));
    this.cdr.detectChanges();
  }

  agregarPermiso(permiso: Permiso) {
    const existe = this.permisosSeleccionados.find((p) => p.idPermiso === permiso.idPermiso);
    if (!existe) {
      this.permisosSeleccionados.push(permiso);
    }
    this.textoBusqueda = '';
    this.permisosFiltrados = [...this.permisosBase];
    this.cdr.detectChanges();
  }

  quitarPermiso(idPermiso: number) {
    this.permisosSeleccionados = this.permisosSeleccionados.filter(
      (p) => p.idPermiso !== idPermiso,
    );
    this.cdr.detectChanges();
  }

  esPermisoSeleccionado(idPermiso: number): boolean {
    return !!this.permisosSeleccionados.find((p) => p.idPermiso === idPermiso);
  }

  toggleModal(open: boolean) {
    this.modalOpen = open;
    if (open) {
      this.roleForm = { name: '', description: '' };
      this.permisosSeleccionados = [];
      this.textoBusqueda = '';
      this.permisosFiltrados = [...this.permisosBase];
    }
    this.cdr.detectChanges();
  }

  async confirmCreateRole() {
    if (!this.roleForm.name || this.permisosSeleccionados.length === 0) {
      alert('El rol debe tener nombre y al menos un permiso.');
      return;
    }

    // CAMBIO TÁCTICO: Extraemos los IDs puros para evitar errores de case-sensitivity en PostgreSQL
    const idsPermisos = this.permisosSeleccionados.map((p) => p.idPermiso);

    const { data, error } = await this.supabaseService.client.rpc('registrar_rol_seguridad', {
      p_nombre: this.roleForm.name,
      p_descripcion: this.roleForm.description,
      p_permisos: idsPermisos, // Ahora mandamos: [1, 2, 5, 8]
    });

    if (error) {
      alert('Error crítico de red: ' + error.message);
    } else if (data && !data.success) {
      alert('Error en BD: ' + data.mensaje);
    } else {
      this.toggleModal(false);
      await this.cargarDatosIniciales();
    }
  }

  openTransferModal(role: Role) {
    this.roleToDelete = role;
    this.lifeguardRoleId = null;
    this.transferModalOpen = true;
    this.cdr.detectChanges();
  }

  closeTransferModal() {
    this.transferModalOpen = false;
    this.roleToDelete = null;
    this.lifeguardRoleId = null;
    this.cdr.detectChanges();
  }

  async confirmDeleteAndTransfer() {
    if (!this.roleToDelete || !this.lifeguardRoleId) return;

    const { data, error } = await this.supabaseService.client.rpc('eliminar_rol_seguridad', {
      p_idrol_a_borrar: this.roleToDelete.id,
      p_idrol_destino: Number(this.lifeguardRoleId),
    });

    if (error) {
      alert('Error crítico: ' + error.message);
    } else if (data && !data.success) {
      alert('Error BD: ' + data.mensaje);
    } else {
      this.closeTransferModal();
      await this.cargarDatosIniciales();
    }
  }
}
