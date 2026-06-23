import { TestBed } from '@angular/core/testing';

import { ReportesApiDataService } from './reportes-api-data.service';

describe('ReportesApiDataService', () => {
  let service: ReportesApiDataService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ReportesApiDataService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
