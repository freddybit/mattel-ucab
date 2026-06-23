/* eslint-disable prettier/prettier */
import { Test, TestingModule } from '@nestjs/testing';
import { ReportesService } from './reportes.service';
import { SupabaseService } from '../supabase/supabase.service';
import { describe, it, expect, beforeEach, jest } from '@jest/globals';

describe('ReportesService', () => {
  let service: ReportesService;

  // Construimos el Mock atacando el array vacío directamente (Opción A)
  const mockSupabaseService = {
    getClient: jest.fn().mockReturnValue({
      from: jest.fn().mockReturnValue({
        select: jest.fn().mockResolvedValue({
          data: [] as any[], 
          error: null,
        }),
      }),
    }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ReportesService,
        {
          provide: SupabaseService,
          useValue: mockSupabaseService,
        },
      ],
    }).compile();

    service = module.get<ReportesService>(ReportesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
