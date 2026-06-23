import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SupabaseService } from '../../services/supabase.service';
import { DisenoWizardService } from '../../services/diseno-wizard.service';

export interface CatalogoGenoma {
  id: number;
  nombre: string;
  detalle?: string;
}

@Component({
  selector: 'app-paso2',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './paso2.html',
  styleUrls: ['./paso2.css', '../../layout/layout.css'],
})
export class Paso2 implements OnInit {
  public cargando: boolean = true;

  public catalogos = {
    tonos: [] as CatalogoGenoma[],
    moldes: [] as CatalogoGenoma[],
    disenosBase: [] as CatalogoGenoma[],
  };

  constructor(
    public wizardService: DisenoWizardService,
    private supabaseService: SupabaseService,
    private router: Router,
    private cdr: ChangeDetectorRef,
  ) {}

  async ngOnInit() {
    // Control de flujo: Si el usuario llega aquí sin nombre, lo devolvemos al Paso 1
    if (!this.wizardService.borrador.nombre) {
      this.router.navigate(['/paso1']);
      return;
    }
    await this.cargarCatalogos();
  }

  async cargarCatalogos() {
    this.cargando = true;
    const { data, error } = await this.supabaseService.client.rpc('obtener_catalogos_diseno_paso2');

    if (data && !error) {
      // Mapeo seguro a prueba de minúsculas
      this.catalogos.tonos = data.tonos.map((t: any) => ({
        id: t.idtonopiel || t.idTonoPiel,
        nombre: t.nombre,
        detalle: t.valorclaridad || t.valorClaridad,
      }));

      this.catalogos.moldes = data.moldes.map((m: any) => ({
        id: m.idmolderostro || m.idMoldeRostro,
        nombre: m.nombre,
        detalle: m.descripcion,
      }));

      this.catalogos.disenosBase = data.disenos_base.map((d: any) => ({
        id: d.iddiseno || d.iddiseno || d.idDiseño,
        nombre: d.nombre,
      }));
    } else {
      console.error('Error cargando catálogos del Genoma:', error);
    }
    this.cargando = false;
    this.cdr.detectChanges();
  }

  avanzarPaso3() {
    // Validaciones estrictas: El Diseño Padre es opcional, pero Tono y Molde no.
    const b = this.wizardService.borrador;
    if (!b.idTonoPiel || !b.idMoldeRostro) {
      alert(
        'El Tono de Piel y el Molde de Rostro son campos estrictamente obligatorios para configurar el Genoma.',
      );
      return;
    }

    // Navegamos al Paso 3
    this.router.navigate(['/paso3']);
  }
}
