import { ApiProperty } from '@nestjs/swagger';
import { UserProfileUpdate } from '../domains/update-user-profile';
import { IsInt, IsOptional, IsString, IsEnum } from 'class-validator';
import { Language } from 'src/utils/enums/language.enum';

export class UserProfileUpdateDto {
  @ApiProperty()
  @IsOptional()
  @IsString()
  firstName?: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  lastName?: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  avatarUrl?: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  level?: string;

  @ApiProperty()
  @IsOptional()
  @IsInt()
  xpPoints?: number;

  @ApiProperty()
  @IsOptional()
  @IsInt()
  streakDays?: number;

  @ApiProperty({ enum: Language, example: Language.UK })
  @IsOptional()
  @IsEnum(Language)
  language?: Language;

  static toUserProfileUpdate(
    userProfileUpdateDto: UserProfileUpdateDto,
  ): UserProfileUpdate {
    return {
      firstName: userProfileUpdateDto.firstName,
      lastName: userProfileUpdateDto.lastName,
      avatarUrl: userProfileUpdateDto.avatarUrl,
      level: userProfileUpdateDto.level,
      streakDays: userProfileUpdateDto.streakDays,
      xpPoints: userProfileUpdateDto.xpPoints,
      language: userProfileUpdateDto.language,
    };
  }
}
