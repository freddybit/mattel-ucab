import { Component, Input } from '@angular/core';
import { RouterLink } from '@angular/router';

export type SidebarItem =
  | 'dashboard'
  | 'ingenieria'
  | 'almacen'
  | 'finanzas'
  | 'personal'
  | 'configuracion'
  | 'trazabilidad';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './app-sidebar.html',
})
export class AppSidebar {
  @Input() activeItem: SidebarItem = 'dashboard';

  isActive(item: SidebarItem): boolean {
    return this.activeItem === item;
  }

  linkClass(item: SidebarItem): string {
    const base =
      'nav-item-base flex items-center gap-4 px-8 py-4 transition-all duration-200 group';
    return this.isActive(item)
      ? `${base} nav-active text-white`
      : `${base} text-slate-400 hover:text-white`;
  }
}
