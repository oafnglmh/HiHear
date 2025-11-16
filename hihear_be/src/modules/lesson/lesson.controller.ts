import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { LessonService } from './lesson.service';
import { LessonCreateDto } from './dto/lesson-create.dto';
import { ApiTags } from '@nestjs/swagger';
import { LessonDto } from './dto/lesson.dto';
import { UserEntity } from '../users/entities/user.entity';
import { RequireAdmin, RequireLoggedIn } from 'src/guards/role-container';
import { AuthUser } from 'src/decorator/auth-user.decorator';
import { LessonUpdateDto } from './dto/lesson-update.dto';
import type { Uuid } from 'src/common/types';

@ApiTags('lessons')
@Controller('lessons')
export class LessonController {
  constructor(private readonly lessonService: LessonService) {}

  @Post()
  @RequireLoggedIn()
  @RequireAdmin()
  async create(
    @Body() lessonCreateDto: LessonCreateDto,
    @AuthUser() currentUser: UserEntity,
  ): Promise<LessonDto> {
    return LessonDto.fromDomain(
      await this.lessonService.create(
        currentUser,
        LessonCreateDto.toLessonCreate(lessonCreateDto),
      ),
    );
  }

  @Get()
  async findAll(): Promise<LessonDto[]> {
    return LessonDto.fromDomains(await this.lessonService.findAll());
  }

  @Get(':id')
  async findOne(@Param('id') id: Uuid): Promise<LessonDto> {
    return LessonDto.fromDomain(await this.lessonService.findById(id));
  }

  @Patch(':id')
  @RequireLoggedIn()
  @RequireAdmin()
  async update(
    @AuthUser() currentUser: UserEntity,
    @Body() lessonUpdateDto: LessonUpdateDto,
    @Param('id') id: Uuid,
  ): Promise<LessonDto> {
    return LessonDto.fromDomain(
      await this.lessonService.update(
        currentUser,
        id,
        LessonUpdateDto.toLessonUpdate(lessonUpdateDto),
      ),
    );
  }

  @Delete(':id')
  async remove(@Param('id') id: Uuid): Promise<void> {
    await this.lessonService.remove(id);
  }
}
