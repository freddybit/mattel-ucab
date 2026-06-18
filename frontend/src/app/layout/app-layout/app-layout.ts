import { Component, ViewChild, ElementRef, AfterViewInit } from '@angular/core';
import { Router, RouterOutlet, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import { AppSidebar, SidebarItem } from '../app-sidebar/app-sidebar';
import { AppHeader } from '../app-header/app-header';

@Component({
  selector: 'app-layout',
  standalone: true,
  imports: [AppSidebar, AppHeader, RouterOutlet],
  templateUrl: './app-layout.html',
  styleUrls: ['../layout.css', './app-layout.css'],
})
export class AppLayout implements AfterViewInit {
  @ViewChild('mainContainer', { static: false }) mainContainer!: ElementRef<HTMLElement>;

  activeItem: SidebarItem = 'dashboard';
  scrollable = true;
  mainClass = 'bg-surface-muted';

  private validItems: SidebarItem[] = [
    'dashboard', 'ingenieria', 'almacen', 'finanzas',
    'personal', 'seguridad', 'trazabilidad',
  ];

  constructor(private router: Router) {}

  ngAfterViewInit() {
    this.router.events.pipe(
      filter((e): e is NavigationEnd => e instanceof NavigationEnd)
    ).subscribe(e => {
      const path = e.urlAfterRedirects.split('/')[1] || 'dashboard';
      if (this.validItems.includes(path as SidebarItem)) {
        this.activeItem = path as SidebarItem;
      } else if (path.startsWith('paso')) {
        this.activeItem = 'ingenieria';
      }

      if (['paso1', 'paso2', 'paso3', 'paso4'].includes(path)) {
        this.scrollable = true;
        this.mainClass = 'bg-white';
      } else {
        this.scrollable = true;
        this.mainClass = 'bg-surface-muted';
      }

      this.mainContainer?.nativeElement.scrollTo(0, 0);
    });
  }

  get mainClasses(): string {
    const scroll = this.scrollable ? 'main-scroll' : 'overflow-hidden flex flex-col';
    return `flex-1 min-h-0 ${scroll} ${this.mainClass}`;
  }
}
