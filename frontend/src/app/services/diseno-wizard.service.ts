import { Injectable } from '@angular/core';

export interface BomItem {
  idPieza: number;
  idMaterial: number;
  cantidad: number;
  nombrePieza?: string;
  nombreMaterial?: string;
}

export interface FaseItem {
  nombre: string;
  descripcion: string;
  idEmpleado: number;
  nombreEmpleado?: string;
}

export interface PruebaItem {
  nombre: string;
  descripcion: string;
  tipo: string;
  resultado: string;
  idEmpleado: number;
  nombreEmpleado?: string;
}

export interface DisenoBorrador {
  nombre: string;
  descripcion: string;
  idTipoDiseno: number | null;
  idClasificacionHistorica: number | null;
  idClasificacionExclusividad: number | null;
  idTonoPiel: number | null;
  idMoldeRostro: number | null;
  idDisenoBase: number | null;
  idTipoCuerpo: number | null;
  profesiones: number[];
  restricciones: number[];
  bom: BomItem[];
  fases: FaseItem[];
  pruebas: PruebaItem[];
}

@Injectable({
  providedIn: 'root',
})
export class DisenoWizardService {
  public borrador: DisenoBorrador = {
    nombre: '',
    descripcion: '',
    idTipoDiseno: null,
    idClasificacionHistorica: null,
    idClasificacionExclusividad: null,
    idTonoPiel: null,
    idMoldeRostro: null,
    idDisenoBase: null,
    idTipoCuerpo: null,
    profesiones: [],
    restricciones: [],
    bom: [],
    fases: [],
    pruebas: [],
  };

  limpiarBorrador() {
    this.borrador = {
      nombre: '',
      descripcion: '',
      idTipoDiseno: null,
      idClasificacionHistorica: null,
      idClasificacionExclusividad: null,
      idTonoPiel: null,
      idMoldeRostro: null,
      idDisenoBase: null,
      idTipoCuerpo: null,
      profesiones: [],
      restricciones: [],
      bom: [],
      fases: [],
      pruebas: [],
    };
  }
}
