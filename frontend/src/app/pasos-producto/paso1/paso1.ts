import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SupabaseService } from '../../services/supabase.service';
import { DisenoWizardService } from '../../services/diseno-wizard.service';

export interface CatalogoOpcion {
  id: number;
  nombre: string;
}

@Component({
  selector: 'app-paso1',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './paso1.html',
  styleUrls: ['./paso1.css', '../../layout/layout.css'],
})
export class Paso1 implements OnInit {
  public cargando: boolean = true;

  public catalogos = {
    tipos: [] as CatalogoOpcion[],
    historicas: [] as CatalogoOpcion[],
    exclusividad: [] as CatalogoOpcion[],
  };

  constructor(
    public wizardService: DisenoWizardService,
    private supabaseService: SupabaseService,
    private router: Router,
    private cdr: ChangeDetectorRef,
  ) {}

  async ngOnInit() {
    await this.cargarCatalogos();
  }

  async cargarCatalogos() {
    this.cargando = true;
    const { data, error } = await this.supabaseService.client.rpc('obtener_catalogos_diseno_paso1');

    if (data && !error) {
      // Táctica defensiva: PostgreSQL pasa las llaves a minúsculas en row_to_json.
      // Buscamos la versión en minúsculas (ej: idtipodiseño) o el fallback exacto.
      this.catalogos.tipos = data.tipos.map((t: any) => ({
        id: t.idtipodiseno || t.idtipodiseño || t.idTipoDiseño,
        nombre: t.nombre,
      }));

      this.catalogos.historicas = data.historicas.map((h: any) => ({
        id: h.idclasificacionhistorica || h.idClasificacionHistorica,
        nombre: h.nombre,
      }));

      this.catalogos.exclusividad = data.exclusividad.map((e: any) => ({
        id: e.idclasificacionexclusividad || e.idClasificacionExclusividad,
        nombre: e.nombre,
      }));
    } else {
      console.error('Error cargando catálogos:', error);
    }
    this.cargando = false;
    this.cdr.detectChanges();
  }

  avanzarPaso2() {
    // Validaciones anémicas simples
    const b = this.wizardService.borrador;
    if (
      !b.nombre ||
      !b.idTipoDiseno ||
      !b.idClasificacionHistorica ||
      !b.idClasificacionExclusividad
    ) {
      alert('Por favor, complete todos los campos obligatorios antes de continuar.');
      return;
    }

    // Navegación mediante router
    this.router.navigate(['/paso2']);
  }
}
