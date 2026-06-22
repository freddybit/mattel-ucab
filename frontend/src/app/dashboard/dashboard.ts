import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataTablesModule } from 'angular-datatables';
import { SupabaseService } from '../services/supabase.service';
import { Subject } from 'rxjs';

export interface DashboardKpis {
  disenos: number;
  alertas_stock: number;
  ordenes_b2b: number;
  ventas_totales: number;
}

export interface SecurityAlert {
  id_alerta: number;
  id_usuario: string;
  accion_detectada: string;
  nivel_riesgo: string;
  tiempo_respuesta: string;
}

export interface MoldeRentable {
  nombre_molde: string;
  porcentaje_rentabilidad: number;
}

export interface DistribucionCuerpo {
  nombre_tipo: string;
  porcentaje: number;
  color_hex: string;
  dasharray?: string;
  dashoffset?: number;
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, DataTablesModule],
  templateUrl: './dashboard.html',
  styleUrls: ['../layout/layout.css'],
  styles: [':host { display: block; }'],
})
export class Dashboard implements OnInit, OnDestroy {
  public kpis: DashboardKpis = {
    disenos: 0,
    alertas_stock: 0,
    ordenes_b2b: 0,
    ventas_totales: 0,
  };

  public alertasSeguridad: SecurityAlert[] = [];
  public moldesRentables: MoldeRentable[] = [];
  public tiposCuerpos: DistribucionCuerpo[] = [];
  public cargando = true;

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
      pageLength: 5,
      processing: true,
      language: {
        url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
      },
    };

    await Promise.all([
      this.cargarMetricasGlobales(),
      this.cargarAlertasSeguridad(),
      this.cargarMoldesRentables(),
    ]);

    await this.cargarDistribucionCuerpos();
  }

  ngOnDestroy(): void {
    this.dtTrigger.unsubscribe();
  }

  async cargarMetricasGlobales() {
    const { data, error } = await this.supabaseService.client.rpc('obtener_kpis_dashboard');
    if (data && !error) this.kpis = data as DashboardKpis;
  }

  async cargarAlertasSeguridad() {
    this.cargando = true;
    const { data, error } = await this.supabaseService.client.rpc('obtener_alertas_seguridad');

    if (data && !error) {
      this.alertasSeguridad = data;
      this.cdr.detectChanges();
      setTimeout(() => this.dtTrigger.next(null), 0);
    }
    this.cargando = false;
  }

  async cargarMoldesRentables() {
    const { data, error } = await this.supabaseService.client.rpc('obtener_moldes_rentables');
    if (data && !error) {
      this.moldesRentables = data;
    }
  }

  ejecutarSancion(idUsuario: string) {
    console.log(`Aplicando bloqueo al usuario: ${idUsuario}`);
    alert(`Protocolo Anti-Scalper activado para ${idUsuario}`);
  }

  async cargarDistribucionCuerpos() {
    const { data, error } = await this.supabaseService.client.rpc('obtener_distribucion_tipos_cuerpo');

    if (data && !error) {
      const CIRCUMFERENCE = 553; // 2 * PI * 88
      let cumulativeOffset = 0;

      this.tiposCuerpos = data.map((item: any) => {
          // Calculamos cuánto mide este segmento del círculo
          const sliceLength = (item.porcentaje / 100) * CIRCUMFERENCE;

          // Mapeamos el objeto inyectando la lógica vectorial para el SVG
          const mapeado: DistribucionCuerpo = {
              nombre_tipo: item.nombre_tipo,
              porcentaje: item.porcentaje,
              color_hex: item.color_hex,
              dasharray: `${sliceLength} ${CIRCUMFERENCE}`,
              dashoffset: -cumulativeOffset
          };

          // Acumulamos el desplazamiento para que el siguiente círculo empiece donde termina este
          cumulativeOffset += sliceLength;

          return mapeado;
      });
    }
  }

}

