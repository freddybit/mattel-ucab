import { Component, Input } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';

export type SidebarItem =
  | 'dashboard'
  | 'ingenieria'
  | 'reportes'
  | 'personal'
  | 'seguridad'
  | 'clientes';

interface NavEntry {
  key: SidebarItem;
  label: string;
  icon: string;
  route: string;
  roles: number[];
  enabled: boolean;
}

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './app-sidebar.html',
})
export class AppSidebar {
  @Input() activeItem: SidebarItem = 'dashboard';

  userName: string;
  userRole: string;

  navItems: NavEntry[] = [
    { key: 'dashboard', label: 'Dashboard', icon: 'grid_view', route: '/dashboard', roles: [], enabled: true },
    { key: 'ingenieria', label: 'Ingeniería', icon: 'settings_input_component', route: '/ingenieria', roles: [1, 2, 11, 12], enabled: true },
    { key: 'reportes', label: 'Reportes', icon: 'history', route: '/reportes/oficiales', roles: [1, 2, 3, 4, 5, 6, 11, 12, 13], enabled: true },
    { key: 'personal', label: 'Personal', icon: 'badge', route: '/personal', roles: [1, 9, 11], enabled: true },
    { key: 'clientes', label: 'Clientes', icon: 'group', route: '/clientes', roles: [1], enabled: true },
    { key: 'seguridad', label: 'Seguridad', icon: 'security', route: '/seguridad', roles: [1, 11], enabled: true },
  ];

  constructor(private auth: AuthService, private router: Router) {
    const user = this.auth.getCurrentUser();
    this.userName = user?.username ?? 'Invitado';
    this.userRole = user?.roleName ?? '';

    const roleId = user?.roleId;
    if (roleId) {
      this.navItems.forEach(item => {
        if (item.roles.length > 0 && !item.roles.includes(roleId)) {
          item.enabled = false;
        }
      });
    }
  }

  isActive(item: SidebarItem): boolean {
    return this.activeItem === item;
  }

  linkClass(item: SidebarItem): string {
    const base = 'nav-item-base flex items-center gap-4 px-8 py-4 transition-all duration-200 group';
    if (this.isActive(item)) return `${base} nav-active text-white`;
    const entry = this.navItems.find(n => n.key === item);
    if (entry && !entry.enabled) return `${base} text-slate-600 cursor-not-allowed`;
    return `${base} text-slate-400 hover:text-white`;
  }

  logout(): void {
    this.auth.logout();
    this.router.navigate(['/login']);
  }

  isEnabled(item: SidebarItem): boolean {
    const entry = this.navItems.find(n => n.key === item);
    return entry?.enabled ?? true;
  }
}
