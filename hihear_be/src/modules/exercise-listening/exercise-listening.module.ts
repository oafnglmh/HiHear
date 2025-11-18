import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ListeningEntity } from './entities/listening.entity';

@Module({
  imports: [TypeOrmModule.forFeature([ListeningEntity])],
  controllers: [],
  providers: [],
  exports: [],
})
export class ExerciseListeningModule {}
