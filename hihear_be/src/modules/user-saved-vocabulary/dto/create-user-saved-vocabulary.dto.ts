import { IsNotEmpty, IsString, IsOptional, IsUUID } from 'class-validator';

export class CreateUserSavedVocabularyDto {
  @IsUUID()
  userId: string;

  @IsString()
  @IsNotEmpty()
  word: string;

  @IsString()
  @IsNotEmpty()
  meaning: string;

  @IsString()
  @IsNotEmpty()
  category: string;
}
