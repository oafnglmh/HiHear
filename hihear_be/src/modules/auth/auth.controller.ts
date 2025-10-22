import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { AuthResultDto } from './dto/auth-result.dto';
import { GoogleTokenFormDto } from './dto/google-token-form.dto';

@ApiTags('Auths')
@Controller('auths')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('google')
  async googleLogin(
    @Body() googleTokenFormDto: GoogleTokenFormDto,
  ): Promise<AuthResultDto> {
    return AuthResultDto.fromAuthResult(
      await this.authService.googleLogin(
        GoogleTokenFormDto.toGoogleTokenForm(googleTokenFormDto),
      ),
    );
  }
}
