import { Injectable, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createClient } from '@supabase/supabase-js'; // Ya no necesitas importar 'SupabaseClient'

@Injectable()
export class SupabaseService implements OnModuleInit {
  // 1. Quitamos el tipo explícito aquí para evitar el choque de versiones
  private supabaseClient;

  constructor(private configService: ConfigService) {}

  onModuleInit() {
    const url = this.configService.get<string>('SUPABASE_URL');
    const key = this.configService.get<string>('SUPABASE_KEY');

    this.supabaseClient = createClient(url!, key!);
  }

  // 2. Usamos 'ReturnType<typeof createClient>' para que devuelva el tipo exacto dinámicamente
  getClient(): ReturnType<typeof createClient> {
    return this.supabaseClient;
  }
}
