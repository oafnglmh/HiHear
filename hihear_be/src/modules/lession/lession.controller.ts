import { Body, Controller, Post } from '@nestjs/common';
import { LessionService } from './lession.service';
import { LessionCreateDto } from './dto/lession-create.dto';
import { ApiTags } from '@nestjs/swagger';
import { LessionDto } from './dto/lession.dto';
import { UserEntity } from '../users/entities/user.entity';
import { RequireLoggedIn } from 'src/guards/role-container';
import { AuthUser } from 'src/decorator/auth-user.decorator';

@ApiTags('lession')
@Controller('lession')
export class LessionController {
  constructor(private readonly lessionService: LessionService) {}

  @Post()
  @RequireLoggedIn()
  async create(
    @Body() lessionCreateDto: LessionCreateDto,
    @AuthUser() currentUser: UserEntity,
  ) {
    return LessionDto.fromDomain(
      await this.lessionService.create(
        currentUser,
        LessionCreateDto.toLessionCreate(lessionCreateDto),
      ),
    );
  }
}
