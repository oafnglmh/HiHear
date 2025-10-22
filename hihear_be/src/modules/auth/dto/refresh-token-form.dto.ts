import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { RefreshTokenForm } from '../domain/refresh-token-form';

export class RefreshTokenFormDto {
  @ApiProperty({
    description: 'Refresh token of user',
  })
  @IsString()
  @IsNotEmpty()
  refreshToken: string;

  public static toRefreshTokenForm(
    refreshTokenFormDto: RefreshTokenFormDto,
  ): RefreshTokenForm {
    return {
      refreshToken: refreshTokenFormDto.refreshToken,
    };
  }
}
