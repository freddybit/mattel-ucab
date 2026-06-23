import { Routes } from '@angular/router';
import { AppLayout } from './layout/app-layout/app-layout';
import { LandingPage } from './landing/landing';
import { LoginPage } from './login/login';
import { Dashboard } from './dashboard/dashboard';
import { Ingenieria } from './ingenieria/ingenieria';
import { Trazabilidad } from './trazabilidad/trazabilidad';
import { MotorTrazabilidad } from './trazabilidad/motor-trazabilidad/motor-trazabilidad';
import { ReportesOficiales } from './trazabilidad/reportes-oficiales/reportes-oficiales';
import { Personal } from './personal/personal';
import { Seguridad } from './seguridad/seguridad';
import { Clientes } from './clientes/clientes';
import { Paso1 } from './pasos-producto/paso1/paso1';
import { Paso2 } from './pasos-producto/paso2/paso2';
import { Paso3 } from './pasos-producto/paso3/paso3';
import { Paso4 } from './pasos-producto/paso4/paso4';
import { RegistroClienteNatural } from './registro-cliente-natural/registro-cliente-natural';
import { AuthGuard } from './guards/auth.guard';
import { RoleGuard } from './guards/role.guard';

export const routes: Routes = [
  { path: '', component: LandingPage, pathMatch: 'full' },
  { path: 'login', component: LoginPage },
  { path: 'registro-cliente', component: RegistroClienteNatural },
  {
    path: '',
    component: AppLayout,
    canActivate: [AuthGuard],
    children: [
      { path: 'dashboard', component: Dashboard },
      { path: 'ingenieria', component: Ingenieria, canActivate: [RoleGuard], data: { permissions: ['CONSULTAR'] } },
      {
        path: 'trazabilidad',
        component: Trazabilidad,
        canActivate: [RoleGuard],
        data: { permissions: ['CONSULTAR'] },
        children: [
          { path: '', redirectTo: 'reportes', pathMatch: 'full' },
          { path: 'motor', component: MotorTrazabilidad },
          { path: 'reportes', component: ReportesOficiales },
        ],
      },
      { path: 'personal', component: Personal, canActivate: [RoleGuard], data: { permissions: ['CONSULTAR'] } },
      { path: 'clientes', component: Clientes, canActivate: [RoleGuard], data: { permissions: ['CONSULTAR'] } },
      { path: 'seguridad', component: Seguridad, canActivate: [RoleGuard], data: { permissions: ['CONSULTAR'] } },
      { path: 'paso1', component: Paso1 },
      { path: 'paso2', component: Paso2 },
      { path: 'paso3', component: Paso3 },
      { path: 'paso4', component: Paso4 },
    ],
  },
];
