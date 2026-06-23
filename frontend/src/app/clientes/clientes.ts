import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-clientes',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './clientes.html',
  styleUrls: ['../layout/layout.css'],
  styles: [':host { display: block; }'],
})
export class Clientes {
  public clientes: any[] = [];
  public filtrados: any[] = [];
  public busqueda = '';

  public totalClientes = 24;
  public activosHoy = 8;
  public nuevosMes = 3;

  public pagina = 1;
  public porPagina = 10;

  private mockData = [
    { id: 1, nombreCompleto: 'Alejandro Castillo', pnombre: 'Alejandro', papellido: 'Castillo', cedula: 12345678, direccion: 'Av. Principal, Edif. 42', ubicacion: 'Distrito Capital' },
    { id: 2, nombreCompleto: 'Valentina Márquez', pnombre: 'Valentina', papellido: 'Márquez', cedula: 24890112, direccion: 'Calle 5, Casa 30', ubicacion: 'Miranda' },
    { id: 3, nombreCompleto: 'Ricardo Pérez', pnombre: 'Ricardo', papellido: 'Pérez', cedula: 18223445, direccion: 'Urb. Las Flores, Bloque 7', ubicacion: 'Zulia' },
    { id: 4, nombreCompleto: 'Elena Lozano', pnombre: 'Elena', papellido: 'Lozano', cedula: 20556778, direccion: 'Calle 10, Edif. 15', ubicacion: 'Distrito Capital' },
    { id: 5, nombreCompleto: 'Manuel Herrera', pnombre: 'Manuel', papellido: 'Herrera', cedula: 9554210, direccion: 'Av. Bolívar, Torre 8', ubicacion: 'Carabobo' },
    { id: 6, nombreCompleto: 'Ana Medina', pnombre: 'Ana', papellido: 'Medina', cedula: 10000023, direccion: 'Calle 24, Casa 42', ubicacion: 'Lara' },
    { id: 7, nombreCompleto: 'Viviana Morales', pnombre: 'Viviana', papellido: 'Morales', cedula: 10000001, direccion: 'Calle 6, Casa 9', ubicacion: 'Miranda' },
    { id: 8, nombreCompleto: 'Verónica Castro', pnombre: 'Verónica', papellido: 'Castro', cedula: 10000002, direccion: 'Calle 65, Casa 9', ubicacion: 'Zulia' },
    { id: 9, nombreCompleto: 'Carlos Mendoza', pnombre: 'Carlos', papellido: 'Mendoza', cedula: 11223344, direccion: 'Av. Universidad, Edif. 3', ubicacion: 'Distrito Capital' },
    { id: 10, nombreCompleto: 'María Rodríguez', pnombre: 'María', papellido: 'Rodríguez', cedula: 99887766, direccion: 'Calle 12, Quinta 7', ubicacion: 'Carabobo' },
    { id: 11, nombreCompleto: 'José Contreras', pnombre: 'José', papellido: 'Contreras', cedula: 55443322, direccion: 'Urb. El Paraíso, Casa 15', ubicacion: 'Miranda' },
    { id: 12, nombreCompleto: 'Laura Jiménez', pnombre: 'Laura', papellido: 'Jiménez', cedula: 77665544, direccion: 'Av. Libertador, Torre 12', ubicacion: 'Distrito Capital' },
    { id: 13, nombreCompleto: 'Pedro Rivas', pnombre: 'Pedro', papellido: 'Rivas', cedula: 33221100, direccion: 'Calle 8, Edif. 22', ubicacion: 'Lara' },
    { id: 14, nombreCompleto: 'Sofía Torres', pnombre: 'Sofía', papellido: 'Torres', cedula: 88776655, direccion: 'Av. Las Américas, Casa 5', ubicacion: 'Zulia' },
    { id: 15, nombreCompleto: 'Diego Vargas', pnombre: 'Diego', papellido: 'Vargas', cedula: 44332211, direccion: 'Calle 15, Quinta 20', ubicacion: 'Carabobo' },
    { id: 16, nombreCompleto: 'Camila Rangel', pnombre: 'Camila', papellido: 'Rangel', cedula: 66778899, direccion: 'Urb. La Floresta, Casa 8', ubicacion: 'Miranda' },
    { id: 17, nombreCompleto: 'Andrés Silva', pnombre: 'Andrés', papellido: 'Silva', cedula: 22110099, direccion: 'Av. Andrés Bello, Edif. 6', ubicacion: 'Distrito Capital' },
    { id: 18, nombreCompleto: 'Isabel Peña', pnombre: 'Isabel', papellido: 'Peña', cedula: 55446677, direccion: 'Calle 3, Casa 12', ubicacion: 'Lara' },
    { id: 19, nombreCompleto: 'Luis Salazar', pnombre: 'Luis', papellido: 'Salazar', cedula: 88990011, direccion: 'Av. Principal, Edif. 30', ubicacion: 'Zulia' },
    { id: 20, nombreCompleto: 'Patricia Medina', pnombre: 'Patricia', papellido: 'Medina', cedula: 33112244, direccion: 'Calle 20, Casa 7', ubicacion: 'Carabobo' },
    { id: 21, nombreCompleto: 'Fernando Díaz', pnombre: 'Fernando', papellido: 'Díaz', cedula: 77118822, direccion: 'Urb. Los Jardines, Bloque 3', ubicacion: 'Miranda' },
    { id: 22, nombreCompleto: 'Gabriela Paz', pnombre: 'Gabriela', papellido: 'Paz', cedula: 11557799, direccion: 'Av. Francisco Miranda, Torre 9', ubicacion: 'Distrito Capital' },
    { id: 23, nombreCompleto: 'Roberto Campos', pnombre: 'Roberto', papellido: 'Campos', cedula: 99335577, direccion: 'Calle 18, Casa 25', ubicacion: 'Lara' },
    { id: 24, nombreCompleto: 'Mónica Suárez', pnombre: 'Mónica', papellido: 'Suárez', cedula: 44668800, direccion: 'Av. Las Industrias, Edif. 4', ubicacion: 'Carabobo' },
  ];

  constructor() {
    this.clientes = [...this.mockData];
    this.filtrados = [...this.clientes];
  }

  get paginados(): any[] {
    const inicio = (this.pagina - 1) * this.porPagina;
    return this.filtrados.slice(inicio, inicio + this.porPagina);
  }

  get totalPaginas(): number {
    return Math.ceil(this.filtrados.length / this.porPagina);
  }

  onBuscar() {
    const t = this.busqueda.toLowerCase();
    this.filtrados = this.clientes.filter(c =>
      c.nombreCompleto.toLowerCase().includes(t) ||
      c.cedula.toString().includes(t) ||
      c.ubicacion.toLowerCase().includes(t)
    );
    this.pagina = 1;
  }

  irPagina(p: number) {
    if (p >= 1 && p <= this.totalPaginas) this.pagina = p;
  }

  get paginas(): number[] {
    const arr: number[] = [];
    const t = this.totalPaginas;
    const p = this.pagina;
    for (let i = 1; i <= t; i++) {
      if (i === 1 || i === t || (i >= p - 1 && i <= p + 1)) arr.push(i);
    }
    return arr;
  }

  mostrarPuntos(index: number, pagArray: number[]): boolean {
    return index > 0 && pagArray[index] - pagArray[index - 1] > 1;
  }

  protected readonly Math = Math;
}
