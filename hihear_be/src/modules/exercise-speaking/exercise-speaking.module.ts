import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SpeakingEntity } from './entities/speaking.entity';

@Module({
  imports: [TypeOrmModule.forFeature([SpeakingEntity])],
  controllers: [],
  providers: [],
  exports: [],
})
export class SpeakingGrammaModule {}
