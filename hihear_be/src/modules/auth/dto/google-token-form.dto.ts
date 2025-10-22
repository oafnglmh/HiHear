import { ApiProperty } from '@nestjs/swagger';
import { GoogleTokenForm } from '../domain/google-token-form';
import { IsString } from 'class-validator';

export class GoogleTokenFormDto {
  @ApiProperty()
  @IsString()
  idToken: string;

  public static toGoogleTokenForm(dto: GoogleTokenFormDto): GoogleTokenForm {
    return {
      idToken: dto.idToken,
    };
  }
}
