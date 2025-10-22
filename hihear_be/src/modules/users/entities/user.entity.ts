import { AbstractEntity } from 'src/common/abstract.entity';
import { RoleType } from 'src/guards/role-type';
import { Column, Entity, OneToOne } from 'typeorm';
import { Status } from '../domains/status';
import { UserProfileEntity } from 'src/modules/user-profiles/entities/user-profile.entity';

@Entity('users')
export class UserEntity extends AbstractEntity {
  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  password: string;

  @Column({
    type: 'enum',
    enum: RoleType,
    default: RoleType.USER,
  })
  role: RoleType;

  @Column({
    type: 'enum',
    enum: Status,
    default: Status.ACTIVE,
  })
  status: Status;

  @OneToOne(() => UserProfileEntity, (profile) => profile.user, {
    cascade: true,
  })
  profile: UserProfileEntity;
}
