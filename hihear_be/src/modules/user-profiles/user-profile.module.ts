import { Module } from '@nestjs/common';
import { UserProfileService } from './user-profiles.service';
import { UserProfileEntity } from './entities/user-profile.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserProfileController } from './user-profiles.controller';

@Module({
  imports: [TypeOrmModule.forFeature([UserProfileEntity])],
  controllers: [UserProfileController],
  providers: [UserProfileService],
  exports: [UserProfileService],
})
export class UserProfilesModule {}
