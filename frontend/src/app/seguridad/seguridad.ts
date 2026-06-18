import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

interface ModulePerm {
  name: string;
  icon: string;
  perms: { create: boolean; edit: boolean; delete: boolean; export: boolean };
}

@Component({
  selector: 'app-seguridad',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './seguridad.html',
  styleUrls: ['./seguridad.css'],
})
export class Seguridad {
  saving = false;
  saved = false;

  modules: ModulePerm[] = [
    { name: 'Gestión de Productos', icon: 'inventory', perms: { create: true, edit: true, delete: false, export: true } },
    { name: 'Trazabilidad', icon: 'route', perms: { create: true, edit: false, delete: false, export: true } },
    { name: 'Inventario Global', icon: 'warehouse', perms: { create: true, edit: true, delete: true, export: false } },
    { name: 'Reportes', icon: 'analytics', perms: { create: false, edit: true, delete: false, export: true } },
    { name: 'Seguridad', icon: 'admin_panel_settings', perms: { create: true, edit: true, delete: false, export: true } },
  ];

  selectAll() {
    this.modules.forEach(m => {
      m.perms.create = true;
      m.perms.edit = true;
      m.perms.delete = true;
      m.perms.export = true;
    });
  }

  resetAll() {
    this.modules.forEach(m => {
      m.perms.create = false;
      m.perms.edit = false;
      m.perms.delete = false;
      m.perms.export = false;
    });
  }

  save() {
    this.saving = true;
    setTimeout(() => {
      this.saving = false;
      this.saved = true;
      setTimeout(() => { this.saved = false; }, 2000);
    }, 1000);
  }
}
