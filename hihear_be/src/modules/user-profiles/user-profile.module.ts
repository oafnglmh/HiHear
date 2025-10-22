import { Module } from '@nestjs/common';
import { UserProfileService } from './user-profiles.service';
import { UserProfileEntity } from './entities/user-profile.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([UserProfileEntity])],
  controllers: [],
  providers: [UserProfileService],
  exports: [UserProfileService],
})
export class UserProfilesModule {}
