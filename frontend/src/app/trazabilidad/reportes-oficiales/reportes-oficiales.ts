import { Component } from '@angular/core';
import { ReportesApiDataService } from '../../services/reportes-api-data.service';

@Component({
  selector: 'app-reportes-oficiales',
  standalone: true,
  imports: [],
  templateUrl: './reportes-oficiales.html',
  styleUrls: ['../../layout/layout.css', './reportes-oficiales.css'],
})
export class ReportesOficiales {
  public similitudPorcentaje: number = 80;

  constructor(private readonly reportesService: ReportesApiDataService) {}

  public async descargarReporteLogistica(): Promise<void> {
    await this.reportesService.descargarReportePdf(
      'face-sculpt-hubs',
      'Rpt_FaceSculpt_vs_Paletas.pdf',
    );
  }

  public async descargarReporteTaxonomia(): Promise<void> {
    await this.reportesService.descargarReportePdf(
      'taxonomia-incompleta',
      'Rpt_Lotes_Taxonomia_Incompleta.pdf',
    );
  }

  public async descargarReporteSimilitud(): Promise<void> {
    await this.reportesService.descargarReportePdf(
      'similitud-bom',
      'Rpt_Similitud_Recetas_BOM.pdf',
    );
  }
}
