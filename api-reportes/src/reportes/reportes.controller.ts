import { Controller, Get, Res, HttpStatus } from '@nestjs/common';
import type { Response } from 'express';
import { ReportesService } from './reportes.service';

@Controller('reportes')
export class ReportesController {
  constructor(private readonly reportesService: ReportesService) {}

  @Get('face-sculpt-hubs')
  public async obtenerReporteFaceSculpt(
    @Res() response: Response,
  ): Promise<void> {
    try {
      const bufferPdf = await this.reportesService.procesarReporteFaceSculpt();

      response.set({
        'Content-Type': 'application/pdf',
        'Content-Disposition':
          'attachment; filename=Rpt_FaceSculpt_vs_Paletas.pdf',
        'Content-Length': bufferPdf.length.toString(),
      });

      response.status(HttpStatus.OK).send(bufferPdf);
    } catch (error) {
      const mensajeError =
        error instanceof Error
          ? error.message
          : 'Error desconocido en el servidor';

      response.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
        statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
        message:
          'Fallo al generar el reporte analítico de Face Sculpts en Hubs',
        error: mensajeError,
      });
    }
  }

  @Get('similitud-bom')
  public async obtenerReporteSimilitudBom(
    @Res() response: Response,
  ): Promise<void> {
    try {
      const bufferPdf =
        await this.reportesService.procesarReporteSimilitudBom();

      response.set({
        'Content-Type': 'application/pdf',
        'Content-Disposition':
          'attachment; filename=Rpt_Similitud_Recetas_BOM.pdf',
        'Content-Length': bufferPdf.length.toString(),
      });

      response.status(HttpStatus.OK).send(bufferPdf);
    } catch (error) {
      const mensajeError =
        error instanceof Error
          ? error.message
          : 'Error desconocido en el servidor';

      response.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
        statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
        message: 'Fallo al generar el reporte de duplicidad de recetas BOM',
        error: mensajeError,
      });
    }
  }

  @Get('taxonomia-incompleta')
  public async obtenerReporteTaxonomiaIncompleta(
    @Res() response: Response,
  ): Promise<void> {
    try {
      const bufferPdf = await this.reportesService.procesarReporteTaxonomia();

      response.set({
        'Content-Type': 'application/pdf',
        'Content-Disposition':
          'attachment; filename=Rpt_Lotes_Taxonomia_Incompleta.pdf',
        'Content-Length': bufferPdf.length.toString(),
      });

      response.status(HttpStatus.OK).send(bufferPdf);
    } catch (error) {
      const mensajeError =
        error instanceof Error
          ? error.message
          : 'Error desconocido en el servidor';

      response.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
        statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
        message: 'Fallo al generar el reporte de auditoría de taxonomía base',
        error: mensajeError,
      });
    }
  }
}
