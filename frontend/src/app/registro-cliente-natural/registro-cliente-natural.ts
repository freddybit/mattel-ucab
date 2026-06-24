import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { SupabaseService } from '../services/supabase.service';

export interface Lugar {
  idLugar: number;
  nombre: string;
  tipo: string;
  Lugar_idLugar: number | null; // ID del lugar padre
}

@Component({
  selector: 'app-registro-cliente-natural',
  standalone: true,
  imports: [CommonModule, RouterLink, FormsModule],
  templateUrl: './registro-cliente-natural.html',
  styleUrls: ['./registro-cliente-natural.css'],
})
export class RegistroClienteNatural implements OnInit {
  form = {
    nombreUsuario: '',
    correoElectronico: '',
    password: '',
    confirmPassword: '',
    tipoCedula: 'V',
    cedula: '',
    pNombre: '',
    sNombre: '',
    pApellido: '',
    sApellido: '',
    codigoOperadora: '414',
    numeroAbonado: '',
    idEstado: null as number | null,
    idMunicipio: null as number | null,
    idParroquia: null as number | null,
    direccion: '',
  };

  loading = false;
  errorMsg = '';

  // Catálogos de Lugares
  lugaresBrutos: Lugar[] = [];
  estados: Lugar[] = [];
  municipios: Lugar[] = [];
  parroquias: Lugar[] = [];

  constructor(
    private supabase: SupabaseService,
    private router: Router,
    private cdr: ChangeDetectorRef,
  ) {}

  async ngOnInit() {
    await this.cargarLugares();
  }

  async cargarLugares() {
    // 1. Cambiamos 'Lugar' por 'lugar' en minúsculas
    // 2. Agregamos 'Lugar_idLugar, tipo' al select para que funcionen tus dropdowns en cadena
    const { data, error } = await this.supabase.client
      .from('lugar')
      .select('idlugar, nombre, tipo, lugar_idlugar'); // Usamos minúsculas para las columnas también por seguridad

    if (data && !error) {
      // Guardamos TODOS los lugares brutos primero para que los filtros funcionen
      this.lugaresBrutos = data.map((l: any) => ({
        idLugar: l.idlugar || l.idLugar,
        nombre: l.nombre,
        tipo: l.tipo,
        Lugar_idLugar: l.lugar_idlugar || l.Lugar_idLugar,
      }));

      // Filtramos solo los estados para llenar el primer dropdown
      this.estados = this.lugaresBrutos.filter((l) => l.tipo === 'Estado');
    } else {
      console.error('Error cargando lugares:', error);
    }
    this.cdr.detectChanges();
  }

  onEstadoChange() {
    this.form.idMunicipio = null;
    this.form.idParroquia = null;
    this.parroquias = [];
    this.municipios = this.lugaresBrutos.filter((l) => l.Lugar_idLugar === this.form.idEstado);
  }

  onMunicipioChange() {
    this.form.idParroquia = null;
    this.parroquias = this.lugaresBrutos.filter((l) => l.Lugar_idLugar === this.form.idMunicipio);
  }

  async submit() {
    if (this.loading) return;
    this.errorMsg = '';

    // Validaciones locales
    if (!this.form.nombreUsuario || !this.form.correoElectronico || !this.form.password) {
      this.errorMsg = 'Los datos de la cuenta son obligatorios.';
      return;
    }
    if (this.form.password !== this.form.confirmPassword) {
      this.errorMsg = 'Las contraseñas no coinciden.';
      return;
    }
    if (!this.form.cedula || !this.form.pNombre || !this.form.pApellido) {
      this.errorMsg = 'Los datos personales primarios son obligatorios.';
      return;
    }
    if (!this.form.numeroAbonado) {
      this.errorMsg = 'El número de teléfono es obligatorio.';
      return;
    }
    if (!this.form.idParroquia || !this.form.direccion) {
      this.errorMsg = 'Debe seleccionar la ubicación completa y agregar la dirección detallada.';
      return;
    }

    this.loading = true;
    this.cdr.detectChanges();

    // Armamos el payload final
    const payload = {
      ...this.form,
      Lugar_idLugar: this.form.idParroquia,
    };

    const { data, error } = await this.supabase.client.rpc('registrar_cliente_natural_maestro', {
      p_payload: payload,
    });

    this.loading = false;
    this.cdr.detectChanges();

    if (error) {
      this.errorMsg = 'Error crítico: ' + error.message;
    } else if (data && !data.success) {
      this.errorMsg = 'Error en BD: ' + data.mensaje;
    } else {
      alert('Registro exitoso. Ahora puede iniciar sesión.');
      this.router.navigate(['/login']);
    }
  }
}
