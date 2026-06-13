import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Paso4 } from './paso4';

describe('Paso4', () => {
  let component: Paso4;
  let fixture: ComponentFixture<Paso4>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Paso4],
    }).compileComponents();

    fixture = TestBed.createComponent(Paso4);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
