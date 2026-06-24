import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { SupabaseService } from '../../services/supabase.service';
import { DisenoWizardService } from '../../services/diseno-wizard.service';

@Component({
  selector: 'app-paso4',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './paso4.html',
  styleUrls: ['./paso4.css', '../../layout/layout.css'],
})
export class Paso4 implements OnInit {
  public showModal: boolean = false;
  public procesandoGuardado: boolean = false;
  public idGenerado: string | null = null;

  constructor(
    public wizardService: DisenoWizardService,
    private supabaseService: SupabaseService,
    private router: Router,
    private cdr: ChangeDetectorRef, // JUGADA CLAVE: Inyectamos el detector de cambios
  ) {}

  ngOnInit() {
    if (!this.wizardService.borrador.nombre) {
      this.router.navigate(['/paso1']);
    }
  }

  async confirmarProducto() {
    this.procesandoGuardado = true;
    const payload = this.wizardService.borrador;

    // Forzamos actualización visual al cambiar el estado de carga
    this.cdr.detectChanges();

    const { data, error } = await this.supabaseService.client.rpc(
      'registrar_genoma_barbie_maestro',
      {
        p_payload: payload,
      },
    );

    this.procesandoGuardado = false;

    if (error) {
      alert('Error crítico de red al conectar con PostgreSQL: ' + error.message);
      this.cdr.detectChanges();
    } else if (data && !data.success) {
      alert('Transacción rechazada por la Base de Datos (ROLLBACK):\n' + data.mensaje);
      this.cdr.detectChanges();
    } else {
      // Extracción segura del ID generado
      this.idGenerado = data.idGenerado;
      this.showModal = true;

      // OBLIGAMOS a Angular a despertar y pintar el Modal en el DOM de inmediato
      this.cdr.detectChanges();
    }
  }

  finalizarProceso() {
    this.showModal = false;
    this.wizardService.limpiarBorrador();
    this.cdr.detectChanges();
    this.router.navigate(['/reportes/motor']);
  }
}
