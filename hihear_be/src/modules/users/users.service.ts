import { Injectable } from '@nestjs/common';
import { UserCreate } from './domains/user-create';
import { User } from './domains/user';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from './entities/user.entity';
import { Repository } from 'typeorm';
import { UserProfileService } from '../user-profiles/user-profiles.service';
import { UserProfile } from '../user-profiles/domains/create-user-profile';
import { TokenPayload as GoogleTokenPayload } from 'google-auth-library';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(UserEntity)
    private readonly userRepository: Repository<UserEntity>,
    private readonly userProfileService: UserProfileService,
  ) {}

  async create(userCreate: UserCreate): Promise<User> {
    await this.verifyEmailIsAvailable(userCreate.email);

    const userEntity = this.userRepository.create(
      UserCreate.toEntity(userCreate),
    );

    const saveUser = await this.userRepository.save(userEntity);

    return User.fromEntity(saveUser);
  }

  async createOrGetGoogleUser(
    userCreate: UserCreate,
    tokenPayload: GoogleTokenPayload,
  ): Promise<User> {
    const existingUser = await this.findByEmail(userCreate.email);

    if (existingUser) {
      return existingUser;
    }

    const userEntity = this.userRepository.create(
      UserCreate.toEntity(userCreate),
    );

    const savedUser = await this.userRepository.save(userEntity);

    await this.userProfileService.create(
      savedUser,
      UserProfile.fromGooglePayload(tokenPayload),
    );

    return User.fromEntity(savedUser);
  }

  private async verifyEmailIsAvailable(email: string): Promise<void> {
    const existingUser = await this.userRepository.existsBy({ email });

    if (existingUser) {
      throw new Error('Email is already in use');
    }
  }

  private async findByEmail(email: string): Promise<User | null> {
    const userEntity = await this.userRepository.findOne({
      where: { email },
    });
    return userEntity ? User.fromEntity(userEntity) : null;
  }
}
