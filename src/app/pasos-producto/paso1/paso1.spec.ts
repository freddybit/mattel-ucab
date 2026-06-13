import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Paso1 } from './paso1';

describe('Paso1', () => {
  let component: Paso1;
  let fixture: ComponentFixture<Paso1>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Paso1],
    }).compileComponents();

    fixture = TestBed.createComponent(Paso1);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
