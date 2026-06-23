import { Test, TestingModule } from '@nestjs/testing';
import { SupabaseService } from './supabase.service';
import { ConfigModule } from '@nestjs/config';
import { describe, it, expect, beforeEach } from '@jest/globals';

describe('SupabaseService', () => {
  let service: SupabaseService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      // 👇 2. INCLÚYELO EN LOS IMPORTS DEL TEST MODULE
      imports: [ConfigModule.forRoot()],
      providers: [SupabaseService],
    }).compile();

    service = module.get<SupabaseService>(SupabaseService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
