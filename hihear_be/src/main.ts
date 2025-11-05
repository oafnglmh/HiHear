import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { configureSwagger } from './configuration/config-swagger';
import { configLogging } from './configuration/config-logging';
import { ApiConfigService } from './shared/services/api-config.service';
import { SharedModule } from './shared/shared.module';
import { initializeTransactionalContext } from 'typeorm-transactional';
import { json, urlencoded } from 'express';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  initializeTransactionalContext();
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  app.use(json({ limit: '10mb' }));
  app.use(urlencoded({ extended: true, limit: '10mb' }));

  const configService = app.select(SharedModule).get(ApiConfigService);

  app.setGlobalPrefix(configService.apiPrefix);

  configureSwagger(app, configService);
  configLogging(app, configService);

  await app.listen(configService.serverPort);

  return app;
}
void bootstrap();
