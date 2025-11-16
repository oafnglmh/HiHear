import { Controller, Get, Param } from '@nestjs/common';
import { ExerciseService } from './exercises.service';
import { ExercisesDto } from './dto/exercises.dto';
import type { Uuid } from 'src/common/types';

@Controller('exercises')
export class ExerciseController {
  constructor(private readonly exerciseService: ExerciseService) {}

  @Get()
  async findAll(): Promise<ExercisesDto[]> {
    return ExercisesDto.fromDomains(await this.exerciseService.findAll());
  }

  @Get(':id')
  async getById(@Param('id') id: Uuid): Promise<ExercisesDto> {
    return ExercisesDto.fromDomain(await this.exerciseService.findOne(id));
  }
}
