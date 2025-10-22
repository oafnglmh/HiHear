import { RoleType } from 'src/guards/role-type';
import { UserEntity } from '../entities/user.entity';
import { TokenPayload as GoogleTokenPayload } from 'google-auth-library';

export class UserCreate {
  email: string;

  password: string | null;

  role: RoleType;

  static toEntity(userCreate: UserCreate): Partial<UserEntity> {
    return {
      email: userCreate.email,
      role: userCreate.role,
    };
  }

  static fromGooglePayload(payload: GoogleTokenPayload): UserCreate {
    return {
      email: payload.email ?? '',
      password: null,
      role: RoleType.USER,
    };
  }
}
