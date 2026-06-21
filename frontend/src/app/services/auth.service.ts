import { Injectable } from '@angular/core';
import { SupabaseService } from './supabase.service';

export interface AuthUser {
  id: number;
  username: string;
  email: string;
  roleId: number;
  roleName: string;
  employeeId: number | null;
  clientId: number | null;
  permissions: string[];
}

@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly SESSION_KEY = 'mattelucab_session';
  private readonly TIMEOUT_MS = 8000;
  private currentUser: AuthUser | null = null;

  constructor(private supabase: SupabaseService) {
    this.loadSession();
  }

  async login(email: string, password: string): Promise<{ success: boolean; error?: string }> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), this.TIMEOUT_MS);

    try {
      // 1. Look up user by email
      const { data: users, error: lookupError } = await this.supabase.client
        .from('usuario')
        .select('idusuario, nombreusuario, correoelectronico, contraseña, rol_idrol, empleado_idempleado, clientenatural_idclientenatural')
        .eq('correoelectronico', email)
        .abortSignal(controller.signal)
        .limit(1);

      clearTimeout(timeoutId);

      if (lookupError) {
        console.error('Supabase error:', lookupError);
        return { success: false, error: `Error de conexión: ${lookupError.message}` };
      }
      if (!users || users.length === 0) {
        return { success: false, error: 'Usuario no registrado.' };
      }

      const userRecord: any = users[0];

      // 2. Password check
      if (userRecord.contraseña !== password) {
        return { success: false, error: 'Credenciales inválidas.' };
      }

      // 3. Fetch role + permissions
      const { data: rol, error: rolError } = await this.supabase.client
        .from('rol')
        .select('idrol, nombre')
        .eq('idrol', userRecord.rol_idrol)
        .single();

      if (rolError) {
        console.error('Rol query error:', rolError);
        return { success: false, error: 'Error al obtener información del rol.' };
      }

      const { data: perms, error: permsError } = await this.supabase.client
        .from('rolpermiso')
        .select('permisos_idpermiso')
        .eq('rol_idrol', userRecord.rol_idrol);

      if (permsError) {
        console.error('RolPermiso query error:', permsError);
      }

      let permNames: string[] = [];
      if (perms && perms.length > 0) {
        const permIds = perms.map((p: any) => p.permisos_idpermiso);
        const { data: permisos } = await this.supabase.client
          .from('permiso')
          .select('nombre')
          .in('idpermiso', permIds);
        if (permisos) permNames = permisos.map((p: any) => p.nombre);
      }

      this.currentUser = {
        id: userRecord.idusuario,
        username: userRecord.nombreusuario,
        email: userRecord.correoelectronico,
        roleId: userRecord.rol_idrol,
        roleName: rol?.nombre ?? 'Desconocido',
        employeeId: userRecord.empleado_idempleado,
        clientId: userRecord.clientenatural_idclientenatural,
        permissions: permNames,
      };

      this.saveSession();
      return { success: true };
    } catch (err: any) {
      clearTimeout(timeoutId);
      if (err?.name === 'AbortError') {
        return { success: false, error: 'El servidor no responde. Verifica tu conexión.' };
      }
      console.error('Login error:', err);
      return { success: false, error: err?.message || 'Error inesperado al iniciar sesión.' };
    }
  }

  logout(): void {
    this.currentUser = null;
    localStorage.removeItem(this.SESSION_KEY);
  }

  isAuthenticated(): boolean {
    return this.currentUser !== null;
  }

  getCurrentUser(): AuthUser | null {
    return this.currentUser;
  }

  hasPermission(permName: string): boolean {
    return this.currentUser?.permissions.includes(permName) ?? false;
  }

  hasAnyPermission(permNames: string[]): boolean {
    return permNames.some(p => this.hasPermission(p));
  }

  private saveSession(): void {
    if (this.currentUser) {
      localStorage.setItem(this.SESSION_KEY, JSON.stringify(this.currentUser));
    }
  }

  private loadSession(): void {
    const data = localStorage.getItem(this.SESSION_KEY);
    if (data) {
      try { this.currentUser = JSON.parse(data); } catch { this.currentUser = null; }
    }
  }
}
