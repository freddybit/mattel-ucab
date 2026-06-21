import { Component, OnInit } from '@angular/core';
import { Router, RouterLink, ActivatedRoute } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [RouterLink, FormsModule],
  templateUrl: './login.html',
  styleUrls: ['./login.css'],
})
export class LoginPage implements OnInit {
  passwordVisible = false;
  loading = false;
  errorMsg = '';
  successMsg = '';
  email = '';
  password = '';

  constructor(private router: Router, private auth: AuthService, private route: ActivatedRoute) {}

  ngOnInit() {
    if (this.route.snapshot.queryParamMap.get('registrado') === 'true') {
      this.successMsg = 'Registro exitoso. Ahora puedes iniciar sesión.';
    }
  }

  togglePassword() {
    this.passwordVisible = !this.passwordVisible;
  }

  async login(event: Event) {
    event.preventDefault();
    if (this.loading) return;

    if (!this.email || !this.password) {
      this.errorMsg = 'Completa todos los campos para iniciar sesión.';
      return;
    }

    this.loading = true;
    this.errorMsg = '';

    const result = await this.auth.login(this.email, this.password);
    this.loading = false;

    if (result.success) {
      this.router.navigate(['/dashboard']);
    } else {
      this.errorMsg = result.error ?? 'Error al iniciar sesión.';
    }
  }
}
