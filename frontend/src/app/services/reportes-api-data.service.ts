import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ReportesApiDataService {
  private readonly urlBase: string = 'http://localhost:3000/reportes';

  constructor() {}

  public async descargarReportePdf(endpoint: string, nombreArchivoDefault: string): Promise<void> {
    try {
      const urlCompleta: string = `${this.urlBase}/${endpoint}`;
      const respuesta: Response = await fetch(urlCompleta, {
        method: 'GET',
        headers: {
          Accept: 'application/pdf',
        },
      });

      if (!respuesta.ok) {
        throw new Error(`Error al descargar el archivo: ${respuesta.statusText}`);
      }

      const datosBinarios: Blob = await respuesta.blob();
      const urlBlob: string = window.URL.createObjectURL(datosBinarios);
      const elementoAncla: HTMLAnchorElement = document.createElement('a');

      elementoAncla.href = urlBlob;
      elementoAncla.download = nombreArchivoDefault;
      document.body.appendChild(elementoAncla);
      elementoAncla.click();

      document.body.removeChild(elementoAncla);
      window.URL.revokeObjectURL(urlBlob);
    } catch (error) {
      console.error('Fallo crítico en el servicio de reportería de Angular:', error);
    }
  }
}
