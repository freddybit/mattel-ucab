import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-ingenieria',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './ingenieria.html',
  styleUrls: ['../layout/layout.css'],
  styles: [':host { display: block; }'],
})
export class Ingenieria {}
