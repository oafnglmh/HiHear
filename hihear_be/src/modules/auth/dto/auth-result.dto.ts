import { TokenDto } from './token.dto';
import { ApiProperty } from '@nestjs/swagger';
import { AuthResult } from '../domain/auth-result';
import { UserDto } from '../../users/dto/user.dto';
import { UserProfileDto } from 'src/modules/user-profiles/dto/user-profile.dto';

export class AuthResultDto {
  @ApiProperty()
  token: TokenDto;

  @ApiProperty()
  user: UserDto;

  @ApiProperty()
  profile: UserProfileDto;

  public static fromAuthResult(authResult: AuthResult): AuthResultDto {
    return {
      token: TokenDto.fromToken(authResult.token),
      user: UserDto.fromDomain(authResult.user),
      profile: UserProfileDto.fromDomain(authResult.profile),
    };
  }
}
