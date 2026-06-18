import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-trazabilidad',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, RouterOutlet],
  templateUrl: './trazabilidad.html',
  styleUrls: ['../layout/layout.css', './trazabilidad.css'],
})
export class Trazabilidad {}
