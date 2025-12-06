import { IsBoolean, IsOptional, IsUUID } from 'class-validator';

export class CreateProgressDto {
  @IsUUID()
  user_id: string;

  @IsUUID()
  lesson_id: string;

  @IsOptional()
  @IsBoolean()
  completed?: boolean = true;
}
