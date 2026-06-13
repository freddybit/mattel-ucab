import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-paso4',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './paso4.html',
  styleUrls: ['./paso4.css']
})
export class Paso4 {
  showModal = false;

  confirmarProducto(): void {
    this.showModal = true;
  }
}
