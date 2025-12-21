import { ApiProperty } from '@nestjs/swagger';
import { UserProfile } from '../domains/user-profile';
import type { Uuid } from 'src/common/types';
import { Language } from 'src/utils/enums/language.enum';

export class UserProfileDto {
  @ApiProperty({
    example: '123e4567-e89b-12d3-a456-426614174000',
    description: 'Unique identifier of the user',
  })
  id: Uuid;

  @ApiProperty()
  firstName: string;

  @ApiProperty()
  lastName: string;

  @ApiProperty()
  avatarUrl: string | null;

  @ApiProperty()
  level: string | null;

  @ApiProperty()
  xpPoints: number | null;

  @ApiProperty()
  streakDays: number | null;

  @ApiProperty({ enum: Language, example: Language.UK })
  language: Language;

  @ApiProperty({
    example: '14/10/2025',
    description: 'Time created account',
  })
  createdAt: Date;

  @ApiProperty({
    example: '14/10/2025',
    description: 'Time updated account',
  })
  updatedAt: Date;

  static fromDomain(userProfile: UserProfile): UserProfileDto {
    return {
      id: userProfile.id,
      firstName: userProfile.firstName,
      lastName: userProfile.lastName,
      avatarUrl: userProfile.avatarUrl,
      level: userProfile.level,
      streakDays: userProfile.streakDays,
      xpPoints: userProfile.xpPoints,
      language: userProfile.language,
      createdAt: userProfile.createdAt,
      updatedAt: userProfile.updatedAt,
    };
  }

  static fromDomains(userProfiles: UserProfile[]): UserProfileDto[] {
    return userProfiles.map((userProfile) => this.fromDomain(userProfile));
  }
}
