import { Body, Controller, Patch } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { UserProfileUpdateDto } from './dto/update-user-profile.dto';
import { UserProfileDto } from './dto/user-profile.dto';
import { UserEntity } from '../users/entities/user.entity';
import { AuthUser } from 'src/decorator/auth-user.decorator';
import { UserProfileService } from './user-profiles.service';

@ApiTags('Profile')
@Controller('profile')
export class UserProfileController {
  constructor(private readonly userProfileService: UserProfileService) {}

  @Patch('/me')
  async update(
    @AuthUser() currentUser: UserEntity,
    @Body() userUpdateDto: UserProfileUpdateDto,
  ): Promise<UserProfileDto> {
    return UserProfileDto.fromDomain(
      await this.userProfileService.update(
        currentUser,
        UserProfileUpdateDto.toUserProfileUpdate(userUpdateDto),
      ),
    );
  }
}
