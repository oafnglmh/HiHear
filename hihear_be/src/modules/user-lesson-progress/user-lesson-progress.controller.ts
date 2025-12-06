import { Controller, Post, Get, Body, Param } from '@nestjs/common';
import { UserLessonProgressService } from './user-lesson-progress.service';
import { CreateProgressDto } from './dto/create-progress.dto';

@Controller('user-progress')
export class UserLessonProgressController {
  constructor(private readonly service: UserLessonProgressService) {}

  @Post()
  async addProgress(@Body() dto: CreateProgressDto) {
    return this.service.addProgress(dto);
  }

  @Get(':user_id')
  async getAll(@Param('user_id') user_id: string) {
    return this.service.getAllProgress(user_id);
  }
}
