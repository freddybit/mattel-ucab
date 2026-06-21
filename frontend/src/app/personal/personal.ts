import { Component, HostListener, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataTablesModule } from 'angular-datatables';
import { FormsModule } from '@angular/forms';
import { SupabaseService } from '../services/supabase.service';
import { Subject } from 'rxjs';

@Component({
  selector: 'app-personal',
  standalone: true,
  imports: [CommonModule, DataTablesModule, FormsModule],
  templateUrl: './personal.html',
  styleUrls: ['./personal.css'],
})
export class Personal implements OnInit, OnDestroy {
  public showCreateModal = false;
  public passwordVisible = false;

  public dtOptions: any = {};
  public dtTrigger: Subject<any> = new Subject<any>();
  public cargando = true;

  // Colecciones de Datos
  public listaUsuarios: any[] = [];

  // Catálogos para el Modal
  public listaRoles: any[] = [];
  public listaLugares: any[] = [];
  public listaPuestos: any[] = [];
  public listaDepartamentos: any[] = [];
  public listaTurnos: any[] = [];
  public listaHorarios: any[] = [];

  // Objeto de Registro Integral
  public nuevoRegistro = {
    p_cedula: null,
    p_pnombre: '',
    p_snombre: '',
    p_papellido: '',
    p_sapellido: '',
    p_fechanacimiento: '',
    p_direccion: '',
    p_id_lugar_empleado: null,

    p_username: '',
    p_correo: '',
    p_password: '',
    p_id_rol: null,

    p_id_departamento: null,
    p_id_puesto: null,
    p_salario: null,
    p_id_turno: null,
    p_id_tipo_ubicacion: 1, // Default duro asignado por requerimiento de BD, ajusta según tu modelo
  };

  constructor(private supabaseService: SupabaseService) {}

  async ngOnInit() {
    this.dtOptions = {
      pagingType: 'full_numbers',
      pageLength: 5,
      processing: true,
      language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
    };

    await this.cargarDatos();
  }

  async cargarDatos() {
    this.cargando = true;
    const { data, error } = await this.supabaseService.client.from('usuario').select(`
        idusuario,
        correoelectronico,
        estado,
        empleado (pnombre, papellido),
        rol (nombre)
      `);

    if (error) {
      console.error('Error:', error);
    } else {
      this.listaUsuarios = data || [];
      setTimeout(() => this.dtTrigger.next(null), 0);
    }
    this.cargando = false;
  }

  async openModal() {
    // Carga perezosa masiva de catálogos
    if (this.listaRoles.length === 0) {
      const [roles, lugares, puestos, deptos, turnos, horarios] = await Promise.all([
        this.supabaseService.client.from('rol').select('idrol, nombre'),
        this.supabaseService.client.from('lugar').select('idlugar, nombre'),
        this.supabaseService.client.from('puestotrabajo').select('id, nombre'),
        this.supabaseService.client.from('departamento').select('iddepartamento, nombre'),
        this.supabaseService.client.from('turno').select('idturno, nombre'),
        this.supabaseService.client.from('horario').select('idhorario, dia, horainicio, horafin'),
      ]);

      this.listaRoles = roles.data || [];
      this.listaLugares = lugares.data || [];
      this.listaPuestos = puestos.data || [];
      this.listaDepartamentos = deptos.data || [];
      this.listaTurnos = turnos.data || [];
      this.listaHorarios = horarios.data || [];
    }
    this.showCreateModal = true;
  }

  async guardarRegistro() {
    const { data, error } = await this.supabaseService.client.rpc(
      'registrar_onboarding_completo',
      this.nuevoRegistro,
    );

    if (error) {
      console.error('Error de red/Supabase:', error);
      alert('Error crítico de red.');
    } else if (data && !data.success) {
      alert('Fallo en la base de datos: ' + data.mensaje);
    } else {
      alert('Usuario, Empleado y Asignaciones creadas con éxito.');
      this.closeModal();
      location.reload(); // Refresco forzado para limpiar el modal y recargar la tabla
    }
  }

  closeModal() {
    this.showCreateModal = false;
  }
  togglePassword() {
    this.passwordVisible = !this.passwordVisible;
  }

  @HostListener('document:keydown', ['$event'])
  onKeydown(event: KeyboardEvent) {
    if (event.key === 'Escape' && this.showCreateModal) {
      this.closeModal();
    }
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }
}
