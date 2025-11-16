import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GrammarEntity } from './entities/grammar.entity';

@Module({
  imports: [TypeOrmModule.forFeature([GrammarEntity])],
  controllers: [],
  providers: [],
  exports: [],
})
export class ExerciseGrammaModule {}
