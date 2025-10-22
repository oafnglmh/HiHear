import { Module } from '@nestjs/common';
import { JwtStrategy } from './jwt-strategy.service';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { UsersModule } from '../users/users.module';
import { UserProfilesModule } from '../user-profiles/user-profile.module';
import { UserEntity } from '../users/entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ApiConfigService } from 'src/shared/services/api-config.service';

@Module({
  imports: [
    UsersModule,
    UserProfilesModule,
    JwtModule.registerAsync({
      inject: [ApiConfigService],
      useFactory: (configService: ApiConfigService) => ({
        secret: configService.jwtSecret,
        signOptions: { expiresIn: '1d' },
      }),
    }),
    TypeOrmModule.forFeature([UserEntity]),
  ],
  providers: [JwtStrategy, AuthService],
  controllers: [AuthController],
  exports: [JwtStrategy, JwtModule],
})
export class AuthModule {}
