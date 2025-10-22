import { Module } from '@nestjs/common';
import { UserService } from './users.service';
import { UsersController } from './users.controller';
import { UserEntity } from './entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserProfilesModule } from '../user-profiles/user-profile.module';

@Module({
  imports: [TypeOrmModule.forFeature([UserEntity]), UserProfilesModule],
  controllers: [UsersController],
  providers: [UserService],
  exports: [UserService],
})
export class UsersModule {}
