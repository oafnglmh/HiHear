/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { InjectRepository } from '@nestjs/typeorm';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { Repository } from 'typeorm';
import { ApiConfigService } from '../../shared/services/api-config.service';
import { UserEntity } from '../users/entities/user.entity';
import { RoleType } from '../../guards/role-type';
import { emptyUuid } from '../../utils/uuid.utils';
import { UserProfileEntity } from '../user-profiles/entities/user-profile.entity';
import { Uuid } from 'src/common/types';

export const guestUser: Partial<UserEntity> = {
  id: emptyUuid,
  createdAt: new Date(),
  updatedAt: new Date(),
  email: 'Guest',
  role: RoleType.USER,
};

export const guestUserProfile: Partial<UserProfileEntity> = {
  firstName: 'Guest',
  lastName: 'Guest',
};

interface IJwtPayload {
  exp: number;
  iat: number;
  auth_time: number;
  jti: string;
  iss: string;
  aud: string;
  sub: string;
  typ: string;
  azp: string;
  sid: string;
  acr: string;
  realm_access: {
    roles: string[];
  };
  resource_access: {
    account: {
      roles: string[];
    };
  };
  scope: string;
  email_verified: boolean;
  name: string;
  preferred_username: string;
  given_name: string;
  family_name: string;
  email: string;
}

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    config: ApiConfigService,
    @InjectRepository(UserEntity)
    private readonly userRepository: Repository<UserEntity>,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.jwtSecret,
    });
  }

  async validate(payload: IJwtPayload): Promise<UserEntity> {
    if (!payload || !payload.sub) {
      return { ...guestUser, ...guestUserProfile } as UserEntity;
    }

    const user = await this.userRepository.findOne({
      where: { id: payload.sub as Uuid },
      relations: ['profile'],
    });

    if (!user) {
      return { ...guestUser, ...guestUserProfile } as UserEntity;
    }

    return user;
  }
}
