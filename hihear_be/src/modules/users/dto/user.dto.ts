import type { Uuid } from 'src/common/types';
import { RoleType } from 'src/guards/role-type';
import { ApiProperty } from '@nestjs/swagger';
import { User } from '../domains/user';
import { Status } from '../domains/status';

export class UserDto {
  @ApiProperty({
    example: '123e4567-e89b-12d3-a456-426614174000',
    description: 'Unique identifier of the user',
  })
  id: Uuid;

  @ApiProperty({
    example: 'john@gmail.com',
    description: 'Email of the user',
  })
  email: string;

  @ApiProperty({
    example: 'USER',
    description: 'Role of user',
  })
  role?: RoleType;

  @ApiProperty({
    example: 'active',
    description: 'Status of user',
  })
  status?: Status;

  @ApiProperty({
    example: '14/10/2025',
    description: 'Time created account',
  })
  createdAt: Date;

  @ApiProperty({
    example: '14/10/2025',
    description: 'Time updated account',
  })
  updatedAt: Date;

  static fromDomain(user: User): UserDto {
    return {
      id: user.id,
      email: user.email,
      role: user.role,
      status: user.status,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    };
  }

  static fromDomains(users: User[]): UserDto[] {
    return users.map((user) => this.fromDomain(user));
  }
}
