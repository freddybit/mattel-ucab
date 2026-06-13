import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Paso3 } from './paso3';

describe('Paso3', () => {
  let component: Paso3;
  let fixture: ComponentFixture<Paso3>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Paso3],
    }).compileComponents();

    fixture = TestBed.createComponent(Paso3);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
