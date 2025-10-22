/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import _ from 'lodash';
import { RoleType } from 'src/guards/role-type';
import { UserEntity } from '../entities/user.entity';
import { Uuid } from '../../../common/types';
import { Status } from './status';

export class User {
  id: Uuid;

  email: string;

  role: RoleType;

  status: Status;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(userEntity: UserEntity): User {
    return {
      id: userEntity.id,
      email: userEntity.email,
      role: userEntity.role,
      status: userEntity.status,
      createdAt: userEntity.createdAt,
      updatedAt: userEntity.updatedAt,
    };
  }

  static fromEntities(entities: UserEntity[]): User[] {
    return _.map(entities, (e) => User.fromEntity(e)) as User[];
  }
}
