import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { DataTablesModule } from 'angular-datatables';
import { SupabaseService } from '../../services/supabase.service';
import { Subject } from 'rxjs';

export interface TrazabilidadItem {
  sku: string;
  nombre_producto: string;
  lote_produccion: string;
  fecha_ensamblaje: Date;
  estado_unidad: string;
}

@Component({
  selector: 'app-motor-trazabilidad',
  standalone: true,
  imports: [CommonModule, FormsModule, DataTablesModule],
  templateUrl: './motor-trazabilidad.html',
  styleUrl: '../../layout/layout.css',
})
export class MotorTrazabilidad implements OnInit, OnDestroy {
  public loteBusqueda: string = '';
  public resultados: TrazabilidadItem[] = [];
  public cargando: boolean = false;
  public busquedaRealizada: boolean = false;

  // --- VARIABLES DE DATATABLES ---
  public dtOptions: any = {};
  public dtTrigger: Subject<any> = new Subject<any>();

  constructor(
    private supabaseService: SupabaseService,
    private cdr: ChangeDetectorRef,
  ) {}

  ngOnInit(): void {
    this.dtOptions = {
      destroy: true,
      pagingType: 'full_numbers',
      pageLength: 10,
      processing: true,
      language: {
        url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
      },
    };
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  async ejecutarAnalisis() {
    if (!this.loteBusqueda || this.loteBusqueda.trim() === '') {
      return;
    }

    this.cargando = true;
    this.resultados = [];

    const { data, error } = await this.supabaseService.client.rpc(
      'analizar_trazabilidad_materia_prima',
      { p_codigo_lote: this.loteBusqueda.trim() },
    );

    if (data && !error) {
      console.log('Datos del Genoma extraídos de BD:', data); // <-- Revisa la consola F12
      this.resultados = data;
    } else {
      console.error('Error al trazar materia prima:', error);
    }

    this.cargando = false;

    // Forzamos el redibujado de la tabla para que Angular pinte los <tr>
    this.cdr.detectChanges();

    // JUGADA CLAVE: setTimeout obliga a DataTables a esperar a que el DOM esté listo
    setTimeout(() => {
      this.dtTrigger.next(null);
    }, 0);
  }

  obtenerClaseEstado(estado: string): string {
    const est = estado.toLowerCase();
    if (est.includes('cuarentena') || est.includes('retenido')) {
      return 'bg-error-container text-on-error-container';
    } else if (est.includes('despachado')) {
      return 'bg-tertiary-fixed text-on-tertiary-fixed';
    } else {
      return 'bg-surface-container-high text-on-surface-variant';
    }
  }
}
