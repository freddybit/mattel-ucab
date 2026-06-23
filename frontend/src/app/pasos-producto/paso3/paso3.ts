import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SupabaseService } from '../../services/supabase.service';
import { DisenoWizardService } from '../../services/diseno-wizard.service';

export interface CatalogoBase {
  id: number;
  nombre: string;
}

export interface EmpleadoOpcion {
  id: number;
  nombre_completo: string;
}

@Component({
  selector: 'app-paso3',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './paso3.html',
  styleUrls: ['./paso3.css', '../../layout/layout.css'],
})
export class Paso3 implements OnInit {
  public cargando: boolean = true;

  public catalogos = {
    cuerpos: [] as CatalogoBase[],
    profesiones: [] as CatalogoBase[],
    restricciones: [] as CatalogoBase[],
    piezas: [] as CatalogoBase[],
    materiales: [] as CatalogoBase[],
    empleados: [] as EmpleadoOpcion[],
  };

  // Estados temporales para los múltiples sub-formularios
  public selProfesion: number | null = null;
  public selRestriccion: number | null = null;
  public formBom = {
    idPieza: null as number | null,
    idMaterial: null as number | null,
    cantidad: 1,
  };
  public formFase = { nombre: '', descripcion: '', idEmpleado: null as number | null };
  public formPrueba = {
    nombre: '',
    descripcion: '',
    tipo: '',
    resultado: '',
    idEmpleado: null as number | null,
  };

  constructor(
    public wizardService: DisenoWizardService,
    private supabaseService: SupabaseService,
    private router: Router,
    private cdr: ChangeDetectorRef,
  ) {}

  async ngOnInit() {
    if (!this.wizardService.borrador.nombre) {
      this.router.navigate(['/paso1']);
      return;
    }
    await this.cargarCatalogos();
  }

  async cargarCatalogos() {
    this.cargando = true;
    const { data, error } = await this.supabaseService.client.rpc('obtener_catalogos_diseno_paso3');

    if (data && !error) {
      this.catalogos.cuerpos = data.cuerpos.map((x: any) => ({
        id: x.idtipocuerpo || x.idTipoCuerpo,
        nombre: x.nombre,
      }));
      this.catalogos.profesiones = data.profesiones.map((x: any) => ({
        id: x.idprofesion || x.idProfesion,
        nombre: x.nombre,
      }));
      this.catalogos.restricciones = data.restricciones.map((x: any) => ({
        id: x.idrestriccion || x.idRestriccion,
        nombre: x.nombre,
      }));
      this.catalogos.piezas = data.piezas.map((x: any) => ({
        id: x.idpieza || x.idPieza,
        nombre: x.nombre,
      }));
      this.catalogos.materiales = data.materiales.map((x: any) => ({
        id: x.idmaterial || x.idMaterial,
        nombre: x.nombre,
      }));
      this.catalogos.empleados = data.empleados.map((x: any) => ({
        id: x.idempleado || x.idEmpleado,
        nombre_completo: x.nombre_completo,
      }));
    }
    this.cargando = false;
    this.cdr.detectChanges();
  }

  // --- MÉTODOS DE ARREGLOS EN MEMORIA ---

  agregarProfesion() {
    if (this.selProfesion && !this.wizardService.borrador.profesiones.includes(this.selProfesion)) {
      this.wizardService.borrador.profesiones.push(this.selProfesion);
      this.selProfesion = null;
    }
  }

  quitarProfesion(id: number) {
    this.wizardService.borrador.profesiones = this.wizardService.borrador.profesiones.filter(
      (p) => p !== id,
    );
  }

  agregarRestriccion() {
    if (
      this.selRestriccion &&
      !this.wizardService.borrador.restricciones.includes(this.selRestriccion)
    ) {
      this.wizardService.borrador.restricciones.push(this.selRestriccion);
      this.selRestriccion = null;
    }
  }

  quitarRestriccion(id: number) {
    this.wizardService.borrador.restricciones = this.wizardService.borrador.restricciones.filter(
      (r) => r !== id,
    );
  }

  agregarBom() {
    if (this.formBom.idPieza && this.formBom.idMaterial && this.formBom.cantidad > 0) {
      const pz = this.catalogos.piezas.find((p) => p.id === this.formBom.idPieza);
      const mt = this.catalogos.materiales.find((m) => m.id === this.formBom.idMaterial);
      this.wizardService.borrador.bom.push({
        idPieza: this.formBom.idPieza,
        idMaterial: this.formBom.idMaterial,
        cantidad: this.formBom.cantidad,
        nombrePieza: pz?.nombre,
        nombreMaterial: mt?.nombre,
      });
      this.formBom = { idPieza: null, idMaterial: null, cantidad: 1 };
    }
  }

  quitarBom(index: number) {
    this.wizardService.borrador.bom.splice(index, 1);
  }

  agregarFase() {
    if (this.formFase.nombre && this.formFase.idEmpleado) {
      const emp = this.catalogos.empleados.find((e) => e.id === this.formFase.idEmpleado);
      this.wizardService.borrador.fases.push({
        nombre: this.formFase.nombre,
        descripcion: this.formFase.descripcion,
        idEmpleado: this.formFase.idEmpleado,
        nombreEmpleado: emp?.nombre_completo,
      });
      this.formFase = { nombre: '', descripcion: '', idEmpleado: null };
    }
  }

  quitarFase(index: number) {
    this.wizardService.borrador.fases.splice(index, 1);
  }

  agregarPrueba() {
    if (this.formPrueba.nombre && this.formPrueba.tipo && this.formPrueba.idEmpleado) {
      const emp = this.catalogos.empleados.find((e) => e.id === this.formPrueba.idEmpleado);
      this.wizardService.borrador.pruebas.push({
        nombre: this.formPrueba.nombre,
        descripcion: this.formPrueba.descripcion,
        tipo: this.formPrueba.tipo,
        resultado: this.formPrueba.resultado,
        idEmpleado: this.formPrueba.idEmpleado,
        nombreEmpleado: emp?.nombre_completo,
      });
      this.formPrueba = { nombre: '', descripcion: '', tipo: '', resultado: '', idEmpleado: null };
    }
  }

  quitarPrueba(index: number) {
    this.wizardService.borrador.pruebas.splice(index, 1);
  }

  obtenerNombreCatalogo(id: number, catalogo: CatalogoBase[]): string {
    return catalogo.find((item) => item.id === id)?.nombre || 'Desconocido';
  }

  avanzarPaso4() {
    if (!this.wizardService.borrador.idTipoCuerpo) {
      alert('Debe seleccionar un Tipo de Cuerpo base.');
      return;
    }
    // Navegamos al Paso 4 que ahora será únicamente una pantalla de Review y Botón de Guardado
    this.router.navigate(['/paso4']);
  }
}
