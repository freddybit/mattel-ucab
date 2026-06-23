import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create(AppModule);
  app.enableCors();

  const port = process.env.PORT ?? 3000;
  await app.listen(port);

  // 👈 2. Metemos los mensajes informativos con estilo
  logger.log(`🚀 El servidor de reportes está corriendo exitosamente`);
  logger.log(`🌍 Local:   http://localhost:${port}`);
  logger.log(`📡 Network: http://127.0.0.1:${port}`);
  logger.log(
    `📊 Puedes revisar jsreport en el puerto donde levantaste tu Docker (ej: http://localhost:5488)`,
  );
}
void bootstrap();
