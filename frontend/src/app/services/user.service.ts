import { Injectable } from '@angular/core';
import { AuthService, AuthUser } from './auth.service';

@Injectable({ providedIn: 'root' })
export class UserService {
  constructor(private auth: AuthService) {}

  getUser(): { name: string; email: string; role: string } {
    const u = this.auth.getCurrentUser();
    if (u) {
      return { name: u.username, email: u.email, role: u.roleName };
    }
    return { name: 'Invitado', email: '', role: '' };
  }

  hasPermission(perm: string): boolean {
    return this.auth.hasPermission(perm);
  }

  hasAnyPermission(perms: string[]): boolean {
    return this.auth.hasAnyPermission(perms);
  }

  isLoggedIn(): boolean {
    return this.auth.isAuthenticated();
  }
}
