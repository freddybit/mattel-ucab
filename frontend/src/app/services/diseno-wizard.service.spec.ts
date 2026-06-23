import { TestBed } from '@angular/core/testing';

import { DisenoWizardService } from './diseno-wizard.service';

describe('DisenoWizardService', () => {
  let service: DisenoWizardService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DisenoWizardService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
