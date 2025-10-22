import { UserProfileEntity } from '../entities/user-profile.entity';
import { TokenPayload as GoogleTokenPayload } from 'google-auth-library';

export class UserProfile {
  firstName: string;

  lastName: string;

  static toEntity(userProfile: UserProfile): Partial<UserProfileEntity> {
    return {
      firstName: userProfile.firstName,
      lastName: userProfile.lastName,
    };
  }

  static fromEntity(userProfileEntity: UserProfileEntity): UserProfile {
    return {
      firstName: userProfileEntity.firstName,
      lastName: userProfileEntity.lastName,
    };
  }

  static fromGooglePayload(payload: GoogleTokenPayload): UserProfile {
    return {
      firstName: payload.given_name ?? '',
      lastName: payload.family_name ?? '',
    };
  }
}
