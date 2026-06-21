import { Component, HostListener } from '@angular/core';

export interface Role {
  id: number;
  name: string;
  description: string;
  icon: string;
  permsCount: number;
}

export interface ModulePerms {
  crear: boolean;
  editar: boolean;
  eliminar: boolean;
  exportar: boolean;
}

export interface SecurityModule {
  id: string;
  label: string;
  icon: string;
  description: string;
  perms: ModulePerms;
}

@Component({
  selector: 'app-seguridad',
  standalone: true,
  templateUrl: './seguridad.html',
  styleUrls: ['./seguridad.css'],
})
export class Seguridad {
  roles: Role[] = [
    { id: 1, name: 'Administrador', description: 'Acceso total a todas las funciones del sistema Dream Legacy.', icon: 'admin_panel_settings', permsCount: 4 },
    { id: 2, name: 'Ingeniero I+D', description: 'Gestión técnica de prototipos y especificaciones de producto.', icon: 'engineering', permsCount: 3 },
  ];

  modalOpen = false;
  selectedTemplate = 'admin';

  modules: SecurityModule[] = [
    {
      id: 'productos', label: 'Gestión de Productos', icon: 'inventory_2',
      description: 'Configuración de acceso para el módulo de gestión de productos',
      perms: { crear: true, editar: true, eliminar: true, exportar: true },
    },
    {
      id: 'trazabilidad', label: 'Trazabilidad', icon: 'account_tree',
      description: 'Configuración de acceso para el módulo de trazabilidad',
      perms: { crear: true, editar: true, eliminar: true, exportar: true },
    },
    {
      id: 'inventario', label: 'Inventario Global', icon: 'language',
      description: 'Configuración de acceso para el módulo de inventario global',
      perms: { crear: true, editar: true, eliminar: true, exportar: true },
    },
    {
      id: 'reportes', label: 'Reportes', icon: 'analytics',
      description: 'Configuración de acceso para el módulo de reportes',
      perms: { crear: true, editar: true, eliminar: true, exportar: true },
    },
    {
      id: 'seguridad', label: 'Seguridad', icon: 'security',
      description: 'Configuración de acceso para el módulo de seguridad',
      perms: { crear: true, editar: true, eliminar: true, exportar: true },
    },
  ];

  private allOff: ModulePerms = { crear: false, editar: false, eliminar: false, exportar: false };
  private allOn: ModulePerms = { crear: true, editar: true, eliminar: true, exportar: true };

  private templates: Record<string, Record<string, ModulePerms>> = {
    admin: {
      productos: this.allOn,
      trazabilidad: this.allOn,
      inventario: this.allOn,
      reportes: this.allOn,
      seguridad: this.allOn,
    },
    editor: {
      productos: { crear: true, editar: true, eliminar: false, exportar: true },
      trazabilidad: { crear: true, editar: false, eliminar: false, exportar: true },
      inventario: { crear: true, editar: true, eliminar: true, exportar: false },
      reportes: { crear: false, editar: true, eliminar: false, exportar: true },
      seguridad: { crear: true, editar: true, eliminar: false, exportar: true },
    },
    viewer: {
      productos: this.allOff,
      trazabilidad: this.allOff,
      inventario: this.allOff,
      reportes: this.allOff,
      seguridad: this.allOff,
    },
  };

  toggleModal(show: boolean) {
    this.modalOpen = show;
    if (!show) this.resetForm();
  }

  applyTemplate(templateId: string) {
    this.selectedTemplate = templateId;
    const perms = this.templates[templateId];
    if (perms) {
      this.modules.forEach(m => {
        const p = perms[m.id];
        if (p) m.perms = { ...p };
      });
    }
  }

  togglePerm(moduleId: string, permKey: keyof ModulePerms) {
    const mod = this.modules.find(m => m.id === moduleId);
    if (mod) {
      mod.perms[permKey] = !mod.perms[permKey];
      this.selectedTemplate = 'custom';
    }
  }

  resetForm() {
    this.applyTemplate('admin');
  }

  get totalActivePerms(): number {
    return this.modules.reduce((sum, m) => {
      return sum + (m.perms.crear ? 1 : 0) + (m.perms.editar ? 1 : 0)
           + (m.perms.eliminar ? 1 : 0) + (m.perms.exportar ? 1 : 0);
    }, 0);
  }

  saveRole(event: Event) {
    event.preventDefault();
    const form = event.target as HTMLFormElement;
    const nameInput = form.querySelector('#role-name') as HTMLInputElement;
    const descInput = form.querySelector('#role-desc') as HTMLTextAreaElement;
    const name = nameInput?.value.trim();
    const desc = descInput?.value.trim();
    if (!name || !desc) return;

    this.roles.push({
      id: this.roles.length + 1,
      name,
      description: desc,
      icon: 'shield',
      permsCount: this.totalActivePerms,
    });
    this.toggleModal(false);
  }

  @HostListener('document:keydown.escape')
  onEscape() {
    if (this.modalOpen) this.toggleModal(false);
  }
}
