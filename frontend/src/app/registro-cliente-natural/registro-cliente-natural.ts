import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { SupabaseService } from '../services/supabase.service';

@Component({
  selector: 'app-registro-cliente-natural',
  standalone: true,
  imports: [RouterLink, FormsModule],
  templateUrl: './registro-cliente-natural.html',
  styleUrls: ['./registro-cliente-natural.css'],
})
export class RegistroClienteNatural {
  form = {
    nombreUsuario: '',
    correoElectronico: '',
    password: '',
    confirmPassword: '',
    tipoCedula: 'V',
    cedula: '',
    genero: 'Masculino',
    pNombre: '',
    sNombre: '',
    pApellido: '',
    sApellido: '',
    codigoOperadora: '0414',
    numeroAbonado: '',
    fechaNacimiento: '',
    estado: '',
    municipio: '',
    parroquia: '',
    direccion: '',
  };

  loading = false;
  errorMsg = '';

  constructor(private supabase: SupabaseService, private router: Router) {}

  async submit() {
    if (this.loading) return;

    this.errorMsg = '';

    if (!this.form.nombreUsuario || !this.form.correoElectronico || !this.form.password) {
      this.errorMsg = 'Completa los campos obligatorios de la cuenta.';
      return;
    }
    if (this.form.password !== this.form.confirmPassword) {
      this.errorMsg = 'Las contraseñas no coinciden.';
      return;
    }
    if (!this.form.cedula || !this.form.pNombre || !this.form.pApellido) {
      this.errorMsg = 'Completa los campos obligatorios del perfil personal.';
      return;
    }

    this.loading = true;

    try {
      const { data: clientes, error: ce } = await this.supabase.client
        .from('clientenatural')
        .insert({
          cedula: parseInt(this.form.cedula, 10),
          pnombre: this.form.pNombre,
          snombre: this.form.sNombre || null,
          papellido: this.form.pApellido,
          sapellido: this.form.sApellido || null,
          direccion: this.form.direccion || null,
        })
        .select('idclientenatural')
        .single();

      if (ce) {
        console.error('ClienteNatural insert error:', ce);
        this.errorMsg = 'Error al crear el perfil personal.';
        this.loading = false;
        return;
      }

      const { error: ue } = await this.supabase.client
        .from('usuario')
        .insert({
          nombreusuario: this.form.nombreUsuario,
          correoelectronico: this.form.correoElectronico,
          contraseña: this.form.password,
          estado: 'Activo',
          fecharegistro: new Date().toISOString().split('T')[0],
          rol_idrol: 3,
          clientenatural_idclientenatural: clientes!.idclientenatural,
        });

      if (ue) {
        console.error('Usuario insert error:', ue);
        this.errorMsg = 'Error al crear la cuenta de usuario.';
        this.loading = false;
        return;
      }

      this.router.navigate(['/login'], { queryParams: { registrado: 'true' } });
    } catch (err: any) {
      console.error('Registration error:', err);
      this.errorMsg = err?.message || 'Error inesperado al registrar.';
      this.loading = false;
    }
  }
}
