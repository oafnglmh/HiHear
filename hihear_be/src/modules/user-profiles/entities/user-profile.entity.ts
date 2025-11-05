import { AbstractEntity } from 'src/common/abstract.entity';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { Language } from 'src/utils/language.enum';
import { Column, Entity, JoinColumn, OneToOne } from 'typeorm';

@Entity('user_profiles')
export class UserProfileEntity extends AbstractEntity {
  @OneToOne(() => UserEntity, (user) => user.profile, { onDelete: 'CASCADE' })
  @JoinColumn()
  user: UserEntity;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ nullable: true })
  avatarUrl: string;

  @Column({ nullable: true })
  level: string;

  @Column({ type: 'int', default: 0 })
  xpPoints: number;

  @Column({ type: 'int', default: 0 })
  streakDays: number;

  @Column({
    type: 'enum',
    enum: Language,
    default: Language.ENGLISH,
    nullable: true,
  })
  language: Language;
}
