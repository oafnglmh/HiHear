import { UserProfileEntity } from '../entities/user-profile.entity';
import { TokenPayload as GoogleTokenPayload } from 'google-auth-library';

export class UserProfileCreate {
  firstName: string;

  lastName: string;

  static toEntity(
    userProfileCreate: UserProfileCreate,
  ): Partial<UserProfileEntity> {
    return {
      firstName: userProfileCreate.firstName,
      lastName: userProfileCreate.lastName,
    };
  }

  static fromEntity(userProfileEntity: UserProfileEntity): UserProfileCreate {
    return {
      firstName: userProfileEntity.firstName,
      lastName: userProfileEntity.lastName,
    };
  }

  static fromGooglePayload(payload: GoogleTokenPayload): UserProfileCreate {
    return {
      firstName: payload.given_name ?? '',
      lastName: payload.family_name ?? '',
    };
  }
}
