import { Component } from '@angular/core';

@Component({
  selector: 'app-trazabilidad',
  standalone: true,
  imports: [],
  templateUrl: './trazabilidad.html',
  styleUrls: ['../layout/layout.css', './trazabilidad.css'],
})
export class Trazabilidad {
  similitudPorcentaje = 80;

  switchTab(tab: string): void {
    const motorContent = document.getElementById('content-motor');
    const reportesContent = document.getElementById('content-reportes');
    const motorTab = document.getElementById('tab-motor');
    const reportesTab = document.getElementById('tab-reportes');

    if (!motorContent || !reportesContent || !motorTab || !reportesTab) return;

    if (tab === 'motor') {
      motorContent.classList.remove('hidden');
      reportesContent.classList.add('hidden');
      motorTab.classList.add('active-tab');
      motorTab.classList.remove('text-on-surface-variant');
      reportesTab.classList.remove('active-tab');
      reportesTab.classList.add('text-on-surface-variant');
    } else {
      motorContent.classList.add('hidden');
      reportesContent.classList.remove('hidden');
      reportesTab.classList.add('active-tab');
      reportesTab.classList.remove('text-on-surface-variant');
      motorTab.classList.remove('active-tab');
      motorTab.classList.add('text-on-surface-variant');
    }
  }
}
