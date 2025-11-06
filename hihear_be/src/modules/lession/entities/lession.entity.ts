import { AbstractEntity } from 'src/common/abstract.entity';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';

@Entity('lession')
export class LessionEntity extends AbstractEntity {
  @Column()
  title: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ length: 100, nullable: true })
  category: string;

  @Column({ length: 10, nullable: true })
  level: string;

  @Column({ type: 'int', default: 0 })
  durationSeconds: number;

  @Column({ type: 'int', default: 0 })
  xpReward: number;

  @ManyToOne(() => LessionEntity, { nullable: true, onDelete: 'SET NULL' })
  prerequisiteLesson: LessionEntity;

  @ManyToOne(() => UserEntity, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  @JoinColumn()
  user: UserEntity;
}
