import { Component, HostListener, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataTablesModule } from 'angular-datatables';
import { SupabaseService } from '../services/supabase.service'; // Ajusta la ruta según tu proyecto

@Component({
  selector: 'app-personal',
  standalone: true,
  imports: [CommonModule, DataTablesModule],
  templateUrl: './personal.html',
  styleUrls: ['./personal.css'],
})
export class Personal implements OnInit {
  public showCreateModal = false;
  public passwordVisible = false;

  // Variables para DataTables y Supabase
  public dtOptions: any = {};
  public listaUsuarios: any[] = [];
  public cargando = true;

  constructor(private supabaseService: SupabaseService) {}

  async ngOnInit() {
    // Configuración pura de DataTables
    this.dtOptions = {
      pagingType: 'full_numbers',
      pageLength: 5,
      processing: true,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
      },
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
      console.error('Detalle del error en Supabase:', error.message, error.details);
    } else {
      this.listaUsuarios = data || [];
    }

    this.cargando = false;
  }

  openModal() {
    this.showCreateModal = true;
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
}
