import { Test, TestingModule } from '@nestjs/testing';
import { ReportesController } from './reportes.controller';
import { ReportesService } from './reportes.service';
import { SupabaseService } from '../supabase/supabase.service'; // 👈 1. Importa el servicio faltante
import { describe, it, expect, beforeEach, jest } from '@jest/globals';

describe('ReportesController', () => {
  let controller: ReportesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ReportesController],
      // 👇 2. Agrega SupabaseService y ReportesService en los providers del test
      providers: [
        ReportesService,
        {
          provide: SupabaseService,
          useValue: {
            // Creamos un "mock" o simulador básico para que el test no intente conectarse real a internet
            getClient: jest.fn().mockReturnValue({
              from: jest.fn().mockReturnThis(),
              select: jest.fn().mockResolvedValue({ data: [], error: null }),
            }),
          },
        },
      ],
    }).compile();

    controller = module.get<ReportesController>(ReportesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
