import { Injectable, OnModuleInit } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';
import * as jsreportModule from 'jsreport-client';

@Injectable()
export class ReportesService implements OnModuleInit {
  private jsreport: any;

  constructor(private supabaseService: SupabaseService) {}

  public onModuleInit(): void {
    const client = (jsreportModule as any).default || jsreportModule;
    this.jsreport = client('http://localhost:5488');
  }

  public async procesarReporteTaxonomia(): Promise<Buffer> {
    const { data, error } = await this.supabaseService
      .getClient()
      .from('vw_rpt_taxonomia_incompleta')
      .select('*');

    if (error)
      throw new Error('Error al extraer datos de la vista de taxonomía');

    return this.generarPdfJsReport('taxonomia_template', { filas: data });
  }

  public async procesarReporteSimilitudBom(): Promise<Buffer> {
    const { data, error } = await this.supabaseService
      .getClient()
      .from('vw_rpt_bom_similitud')
      .select('*');

    if (error)
      throw new Error('Error al extraer datos de la vista de similitud BOM');

    return this.generarPdfJsReport('similitud_bom_template', { filas: data });
  }

  public async procesarReporteFaceSculpt(): Promise<Buffer> {
    const { data, error } = await this.supabaseService
      .getClient()
      .from('vw_rpt_face_sculpt_hubs')
      .select('*');

    if (error)
      throw new Error('Error al extraer datos de la vista de Face Sculpts');

    return this.generarPdfJsReport('face_sculpt_template', { hubs: data });
  }

  private async generarPdfJsReport(
    nombrePlantilla: string,
    datos: any,
  ): Promise<Buffer> {
    try {
      const response = await fetch('http://localhost:5488/api/report', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          template: {
            name: nombrePlantilla,
          },
          data: datos,
          options: {
            chrome: {
              launchOptions: {
                args: [
                  '--disable-web-security',
                  '--allow-file-access-from-files',
                  '--no-sandbox',
                ],
              },
            },
          },
        }),
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(
          `El servidor jsreport devolvió error ${response.status}: ${errorText}`,
        );
      }

      const arrayBuffer = await response.arrayBuffer();
      return Buffer.from(arrayBuffer);
    } catch (error) {
      const msj = error instanceof Error ? error.message : 'Error desconocido';
      throw new Error(
        `Fallo crítico al conectar con jsreport REST API: ${msj}`,
      );
    }
  }
}
