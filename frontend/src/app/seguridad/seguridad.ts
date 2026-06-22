import { Component, HostListener, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
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

@Component({
  selector: 'app-seguridad',
  standalone: true,
  imports: [CommonModule, DataTablesModule, FormsModule],
  templateUrl: './seguridad.html',
  styleUrls: ['./seguridad.css'],
})
export class Seguridad implements OnInit, OnDestroy {
deleteRole(arg0: number,arg1: string) {
throw new Error('Method not implemented.');
}
applyTemplate(arg0: any) {
throw new Error('Method not implemented.');
}
  public roles: Role[] = [];

  // --- VARIABLES DE MODALES ---
  public modalOpen = false;
  public transferModalOpen = false;

  // --- VARIABLES DE BORRADO (TRANSFERENCIA) ---
  public roleToDelete: Role | null = null;
  public lifeguardRoleId: number | null = null;

  // --- VARIABLES DE DATATABLES ---
  public dtOptions: any = {};
  public dtTrigger: Subject<any> = new Subject<any>();
  public cargando = true;

  // --- LOS 4 PERMISOS GLOBALES SIMPLIFICADOS ---
  public globalPerms = {
    consultar: false,
    crear: false,
    modificar: false,
    borrar: false,
  };
selectedTemplate: any;
modules: any;

  constructor(
    private supabaseService: SupabaseService,
    private cdr: ChangeDetectorRef,
  ) {}

  // --- CICLO DE VIDA ---
  async ngOnInit() {
    this.dtOptions = {
      destroy: true, // REINICIALIZACIÓN SEGURA
      pagingType: 'full_numbers',
      pageLength: 5,
      processing: true,
      language: {
        url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
      },
    };
    await this.cargarRoles();
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  // --- LECTURA A LA BASE DE DATOS ---
  async cargarRoles() {
    this.cargando = true;

    const { data, error } = await this.supabaseService.client.from('rol').select(`
            idrol,
            nombre,
            descripcion,
            rolpermiso ( permisos_idpermiso )
        `);

    if (data) {
      this.roles = data.map((r: any) => ({
        id: r.idrol,
        name: r.nombre,
        description: r.descripcion || 'Sin descripción',
        icon: r.nombre.toLowerCase().includes('admin') ? 'admin_panel_settings' : 'shield',
        permsCount: r.rolpermiso ? r.rolpermiso.length : 0,
      }));

      // Obliga a Angular a pintar los <tr>
      this.cdr.detectChanges();
      // DataTables toma el control
      setTimeout(() => this.dtTrigger.next(null), 0);
    }

    this.cargando = false;
  }

  // --- LÓGICA DEL MODAL DE CREAR ROL ---
  toggleModal(show: boolean) {
    this.modalOpen = show;
    if (!show) {
      this.globalPerms = { consultar: false, crear: false, modificar: false, borrar: false };
    }
  }

  private generarArrayPermisos(): string[] {
    const lista: string[] = [];
    if (this.globalPerms.consultar) lista.push('CONSULTAR');
    if (this.globalPerms.modificar) lista.push('MODIFICAR');
    if (this.globalPerms.crear) lista.push('CREAR');
    if (this.globalPerms.borrar) lista.push('BORRAR');
    return lista;
  }

  async saveRole(event: Event) {
    event.preventDefault();
    const form = event.target as HTMLFormElement;
    const nameInput = form.querySelector('#role-name') as HTMLInputElement;
    const descInput = form.querySelector('#role-desc') as HTMLTextAreaElement;

    const name = nameInput?.value.trim();
    const desc = descInput?.value.trim();

    if (!name || !desc) return;

    const p_permisos = this.generarArrayPermisos();

    const { data, error } = await this.supabaseService.client.rpc('registrar_rol_seguridad', {
      p_nombre: name,
      p_descripcion: desc,
      p_permisos: p_permisos,
    });

    if (error) {
      alert('Error crítico de red: ' + error.message);
    } else if (data && !data.success) {
      alert('Error en BD: ' + data.mensaje);
    } else {
      this.toggleModal(false);
      location.reload();
    }
  }

  // --- LÓGICA DE TRANSFERENCIA Y BORRADO ---
  openTransferModal(role: Role) {
    this.roleToDelete = role;
    this.lifeguardRoleId = null;
    this.transferModalOpen = true;
  }

  closeTransferModal() {
    this.transferModalOpen = false;
    this.roleToDelete = null;
    this.lifeguardRoleId = null;
  }

  async confirmDeleteAndTransfer() {
    if (!this.roleToDelete || !this.lifeguardRoleId) return;

    const { data, error } = await this.supabaseService.client.rpc('eliminar_rol_seguridad', {
      p_idrol_a_borrar: this.roleToDelete.id,
      p_idrol_destino: Number(this.lifeguardRoleId),
    });

    if (error) {
      alert('Error crítico de red: ' + error.message);
    } else if (data && !data.success) {
      alert('Error en BD: ' + data.mensaje);
    } else {
      this.closeTransferModal();
      location.reload();
    }
  }

  @HostListener('document:keydown.escape')
  onEscape() {
    if (this.modalOpen) this.toggleModal(false);
    if (this.transferModalOpen) this.closeTransferModal();
  }
}
