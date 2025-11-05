import { Injectable, NotFoundException } from '@nestjs/common';
import { UserProfileEntity } from './entities/user-profile.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { UserProfileCreate } from './domains/create-user-profile';
import { User } from '../users/domains/user';
import { Uuid } from 'src/common/types';
import { UserProfileUpdate } from './domains/update-user-profile';
import { UserProfile } from './domains/user-profile';

@Injectable()
export class UserProfileService {
  constructor(
    @InjectRepository(UserProfileEntity)
    private readonly userProfileRepository: Repository<UserProfileEntity>,
  ) {}

  async create(
    user: User,
    userProfileCreate: UserProfileCreate,
  ): Promise<UserProfile> {
    const userProfileEntity = this.userProfileRepository.create({
      user: user,
      ...UserProfileCreate.toEntity(userProfileCreate),
    });

    await this.userProfileRepository.save(userProfileEntity);

    return UserProfile.fromEntity(userProfileEntity);
  }

  async update(
    user: User,
    userProfileUpdate: UserProfileUpdate,
  ): Promise<UserProfile> {
    const userProfileEntity = await this.findUserOrThrow(user.id);

    return UserProfile.fromEntity(
      await this.userProfileRepository.save({
        id: userProfileEntity.id,
        ...userProfileUpdate,
      }),
    );
  }

  private async findUserOrThrow(id: Uuid): Promise<UserProfileEntity> {
    const userProfileEntity = await this.userProfileRepository.findOneBy({
      user: { id },
    });

    if (!userProfileEntity) {
      throw new NotFoundException(`User profile with id ${id} not found`);
    }

    return userProfileEntity;
  }
}
