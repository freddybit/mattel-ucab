import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { DataTablesModule } from 'angular-datatables';
import { SupabaseService } from '../services/supabase.service';
import { Subject } from 'rxjs';

export interface ClienteItem {
  id: number;
  nombreCompleto: string;
  cedula: number;
  direccion: string;
  ubicacion: string;
  correo: string;
  estado: string;
  fechaRegistro: Date;
}

@Component({
  selector: 'app-clientes',
  standalone: true,
  imports: [CommonModule, DataTablesModule],
  templateUrl: './clientes.html',
  styleUrls: ['../layout/layout.css'],
  styles: [':host { display: block; }'],
})
export class Clientes implements OnInit, OnDestroy {
  public clientes: ClienteItem[] = [];
  public cargando: boolean = true;

  // KPIs Dinámicos
  public totalClientes: number = 0;
  public activosHoy: number = 0;
  public nuevosMes: number = 0;

  // Controladores de DataTables
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
      language: {
        url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
      },
    };

    await this.cargarClientes();
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  async cargarClientes() {
    this.cargando = true;

    const { data, error } = await this.supabaseService.client.rpc('obtener_clientes_naturales');

    if (data && data.length > 0 && !error) {
      // Mapeo defensivo de propiedades desde PostgreSQL
      this.clientes = data.map((c: any) => ({
        id: c.id_cliente,
        nombreCompleto: c.nombre_completo,
        cedula: c.cedula,
        direccion: c.direccion,
        ubicacion: c.ubicacion,
        correo: c.correo_electronico,
        estado: c.estado,
        fechaRegistro: c.fecha_registro,
      }));

      // Extracción de KPIs desde la primera fila
      const stats = data[0].stats_totales;
      if (stats) {
        this.totalClientes = stats.total_clientes || 0;
        this.activosHoy = stats.activos_hoy || 0;
        this.nuevosMes = stats.nuevos_mes || 0;
      }
    } else if (error) {
      console.error('Error al cargar la cartera de clientes:', error);
    }

    this.cargando = false;
    // Obligamos a Angular a redibujar el DOM antes de disparar DataTables
    this.cdr.detectChanges();
    setTimeout(() => this.dtTrigger.next(null), 0);
  }
}
