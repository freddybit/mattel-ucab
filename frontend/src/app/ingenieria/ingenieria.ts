import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { DataTablesModule } from 'angular-datatables';
import { SupabaseService } from '../services/supabase.service';
import { Subject } from 'rxjs';

export interface DisenoItem {
  sku: string;
  nombre: string;
  categoria: string;
  label_exclusividad: string;
  molde_rostro: string;
}

@Component({
  selector: 'app-ingenieria',
  standalone: true,
  imports: [CommonModule, RouterLink, DataTablesModule],
  templateUrl: './ingenieria.html',
  styleUrls: ['../layout/layout.css'],
  styles: [':host { display: block; }'],
})
export class Ingenieria implements OnInit, OnDestroy {
  public disenos: DisenoItem[] = [];
  public cargando: boolean = true;

  // Variables para los KPIs reales de diseño
  public kpiTotalDisenos: number = 0;
  public kpiErasActivas: number = 0;
  public kpiMoldesUso: number = 0;
  public kpiRestricciones: number = 0;

  // DataTables
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

    await this.cargarDisenos();
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  async cargarDisenos() {
    this.cargando = true;

    const { data, error } = await this.supabaseService.client.rpc('obtener_catalogo_disenos');

    if (data && data.length > 0 && !error) {
      this.disenos = data as DisenoItem[];

      // Extraemos los contadores reales agregados desde la primera fila del payload
      const stats = data[0].stats_totales;
      if (stats) {
        this.kpiTotalDisenos = stats.total_disenos || 0;
        this.kpiErasActivas = stats.eras_activas || 0;
        this.kpiMoldesUso = stats.moldes_uso || 0;
        this.kpiRestricciones = stats.restricciones || 0;
      }
    } else {
      console.error('Error al cargar el catálogo de diseños:', error);
    }

    this.cargando = false;
    this.cdr.detectChanges();
    setTimeout(() => this.dtTrigger.next(null), 0);
  }
}
