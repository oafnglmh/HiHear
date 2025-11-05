import { UserProfileEntity } from '../entities/user-profile.entity';

export class UserProfileUpdate {
  firstName?: string;

  lastName?: string;

  avatarUrl?: string;

  xpPoints?: number;

  streakDays?: number;

  level?: string;

  static toEntity(
    userProfileUpdate: UserProfileUpdate,
  ): Partial<UserProfileEntity> {
    return {
      firstName: userProfileUpdate.firstName,
      lastName: userProfileUpdate.lastName,
      avatarUrl: userProfileUpdate.avatarUrl,
      xpPoints: userProfileUpdate.xpPoints,
      streakDays: userProfileUpdate.streakDays,
      level: userProfileUpdate.level,
    };
  }
}
