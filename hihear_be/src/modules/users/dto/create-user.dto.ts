import { ApiProperty } from '@nestjs/swagger';
import { UserCreate } from '../domains/user-create';
import { IsEmail, IsEnum, IsString, MinLength } from 'class-validator';
import { RoleType } from 'src/guards/role-type';

export class UserCreateDto {
  @ApiProperty({
    example: 'nguyenvana@gmail.com',
    description: 'Email of user',
  })
  @IsEmail()
  email: string;

  @ApiProperty({
    description: 'Password of user',
  })
  @IsString()
  @MinLength(6)
  password: string;

  @ApiProperty({
    example: 'USER',
    description: 'Role of user',
  })
  @IsEnum(RoleType)
  role: RoleType;

  static toUserCreate(userCreateDto: UserCreateDto): UserCreate {
    return {
      email: userCreateDto.email,
      role: userCreateDto.role,
      password: userCreateDto.password,
    };
  }
}
