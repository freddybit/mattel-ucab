import { Routes } from '@angular/router';
import { Paso1 } from './pasos-producto/paso1/paso1';
import { Paso2 } from './pasos-producto/paso2/paso2';
import { Paso3 } from './pasos-producto/paso3/paso3';
import { Paso4 } from './pasos-producto/paso4/paso4';

export const routes: Routes = [
  { path: 'paso1', component: Paso1 },
  { path: 'paso2', component: Paso2 },
  { path: 'paso3', component: Paso3 },
  { path: 'paso4', component: Paso4 },
  { path: '', redirectTo: '/paso1', pathMatch: 'full' }
];