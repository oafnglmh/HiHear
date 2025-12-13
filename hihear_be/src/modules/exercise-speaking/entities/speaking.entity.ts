import { AbstractEntity } from 'src/common/abstract.entity';
import { Column, Entity, ManyToOne } from 'typeorm';
import { ExercisesEntity } from 'src/modules/exercises/entities/exercises.entity';

@Entity('speaking')
export class SpeakingEntity extends AbstractEntity {
  @Column({ type: 'text' })
  number: string;

  @Column('text', { array: true })
  read: string[];

  @ManyToOne(() => ExercisesEntity, (exercise) => exercise.speakings, {
    onDelete: 'CASCADE',
  })
  exercise: ExercisesEntity;
}
