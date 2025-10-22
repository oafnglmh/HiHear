import { Injectable } from '@nestjs/common';
import { UserProfileEntity } from './entities/user-profile.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { UserProfile } from './domains/create-user-profile';
import { User } from '../users/domains/user';

@Injectable()
export class UserProfileService {
  constructor(
    @InjectRepository(UserProfileEntity)
    private readonly userProfileRepository: Repository<UserProfileEntity>,
  ) {}

  async create(user: User, userProfile: UserProfile): Promise<UserProfile> {
    const userProfileEntity = this.userProfileRepository.create({
      user: user,
      ...UserProfile.toEntity(userProfile),
    });

    await this.userProfileRepository.save(userProfileEntity);

    return UserProfile.fromEntity(userProfileEntity);
  }
}
