import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { LessionService } from './lession.service';
import { LessionCreateDto } from './dto/lession-create.dto';
import { ApiTags } from '@nestjs/swagger';
import { LessionDto } from './dto/lession.dto';
import { UserEntity } from '../users/entities/user.entity';
import { RequireAdmin, RequireLoggedIn } from 'src/guards/role-container';
import { AuthUser } from 'src/decorator/auth-user.decorator';
import { LessionUpdateDto } from './dto/lession-update.dto';
import type { Uuid } from 'src/common/types';

@ApiTags('lession')
@Controller('lession')
export class LessionController {
  constructor(private readonly lessionService: LessionService) {}

  @Post()
  @RequireLoggedIn()
  @RequireAdmin()
  async create(
    @Body() lessionCreateDto: LessionCreateDto,
    @AuthUser() currentUser: UserEntity,
  ): Promise<LessionDto> {
    return LessionDto.fromDomain(
      await this.lessionService.create(
        currentUser,
        LessionCreateDto.toLessionCreate(lessionCreateDto),
      ),
    );
  }

  @Get()
  async findAll(): Promise<LessionDto[]> {
    return LessionDto.fromDomains(await this.lessionService.findAll());
  }

  @Get(':id')
  async findOne(@Param('id') id: Uuid): Promise<LessionDto> {
    return LessionDto.fromDomain(await this.lessionService.findById(id));
  }

  @Patch(':id')
  @RequireLoggedIn()
  @RequireAdmin()
  async update(
    @AuthUser() currentUser: UserEntity,
    @Body() lessionUpdateDto: LessionUpdateDto,
    @Param('id') id: Uuid,
  ): Promise<LessionDto> {
    return LessionDto.fromDomain(
      await this.lessionService.update(
        currentUser,
        id,
        LessionUpdateDto.toLessionUpdate(lessionUpdateDto),
      ),
    );
  }

  @Delete(':id')
  async remove(@Param('id') id: Uuid): Promise<void> {
    await this.lessionService.remove(id);
  }
}
