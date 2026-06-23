import { Module, Global } from '@nestjs/common';
import { SupabaseService } from './supabase.service';

@Global() // Esto hace que el módulo sea accesible en toda la app sin re-importarlo
@Module({
  providers: [SupabaseService],
  exports: [SupabaseService], // Crucial para que otros lo usen
})
export class SupabaseModule {}
