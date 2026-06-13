import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PasosProducto } from './pasos-producto';

describe('PasosProducto', () => {
  let component: PasosProducto;
  let fixture: ComponentFixture<PasosProducto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PasosProducto],
    }).compileComponents();

    fixture = TestBed.createComponent(PasosProducto);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
