import { BadRequestException, Injectable } from '@nestjs/common';
import { AuthResult } from './domain/auth-result';
import { UserService } from '../users/users.service';
import { GoogleTokenForm } from './domain/google-token-form';
import { ApiConfigService } from 'src/shared/services/api-config.service';
import { jwtDecode } from 'jwt-decode';
import { OAuth2Client } from 'google-auth-library';
import { UserCreate } from '../users/domains/user-create';
import { User } from '../users/domains/user';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly apiConfigService: ApiConfigService,
    private readonly jwtService: JwtService,
  ) {}

  async googleLogin(googleTokenForm: GoogleTokenForm): Promise<AuthResult> {
    const { clientIds } = this.apiConfigService.googleConfig;
    const { aud } = jwtDecode(googleTokenForm.idToken);

    if (!aud || typeof aud !== 'string' || !clientIds.includes(aud)) {
      throw new BadRequestException('The aud is invalid.');
    }

    const google = new OAuth2Client(aud);

    const tokenPayload = (
      await google.verifyIdToken({
        idToken: googleTokenForm.idToken,
        audience: aud,
      })
    ).getPayload();

    if (!tokenPayload || !tokenPayload.email) {
      throw new BadRequestException('Invalid Google token payload.');
    }

    const user = await this.userService.createOrGetGoogleUser(
      UserCreate.fromGooglePayload(tokenPayload),
      tokenPayload,
    );

    return this.createTokenForUser(user);
  }

  private createTokenForUser(user: User): AuthResult {
    const accessToken = this.generateTokenPayload(user);

    return {
      token: {
        accessToken,
        expiresIn: 3600,
        refreshExpiresIn: 86400,
        refreshToken: '',
        tokenType: 'Bearer',
        sessionState: '',
        scope: 'all',
      },
      user,
    };
  }

  private generateTokenPayload(user: User): string {
    return this.jwtService.sign({
      sub: user.id,
      email: user.email,
      role: user.role,
    });
  }
}
