/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import _ from 'lodash';
import { Uuid } from '../../../common/types';
import { UserProfileEntity } from '../entities/user-profile.entity';

export class UserProfile {
  id: Uuid;

  firstName: string;

  lastName: string;

  avatarUrl: string | null;

  xpPoints: number | null;

  streakDays: number | null;

  level: string | null;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(userProfileEntity: UserProfileEntity): UserProfile {
    return {
      id: userProfileEntity.id,
      firstName: userProfileEntity.firstName,
      lastName: userProfileEntity.lastName,
      avatarUrl: userProfileEntity.avatarUrl,
      xpPoints: userProfileEntity.xpPoints,
      streakDays: userProfileEntity.streakDays,
      level: userProfileEntity.level,
      createdAt: userProfileEntity.createdAt,
      updatedAt: userProfileEntity.updatedAt,
    };
  }

  static fromEntities(entities: UserProfileEntity[]): UserProfile[] {
    return _.map(entities, (e) => UserProfile.fromEntity(e)) as UserProfile[];
  }
}
