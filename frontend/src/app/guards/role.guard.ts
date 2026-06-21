import { Injectable } from '@angular/core';
import { CanActivate, Router, ActivatedRouteSnapshot } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({ providedIn: 'root' })
export class RoleGuard implements CanActivate {
  constructor(private auth: AuthService, private router: Router) {}

  canActivate(route: ActivatedRouteSnapshot): boolean {
    const requiredPerms = route.data?.['permissions'] as string[] | undefined;
    if (!requiredPerms || requiredPerms.length === 0) return true;
    if (this.auth.hasAnyPermission(requiredPerms)) return true;
    this.router.navigate(['/dashboard']);
    return false;
  }
}
