import { AbstractEntity } from 'src/common/abstract.entity';
import { Column, Entity, ManyToOne } from 'typeorm';
import { ExercisesEntity } from 'src/modules/exercises/entities/exercises.entity';

@Entity('vocabularies')
export class VocabularyEntity extends AbstractEntity {
  @ManyToOne(() => ExercisesEntity, (exercise) => exercise.vocabularies, {
    onDelete: 'CASCADE',
  })
  exercise: ExercisesEntity;

  @Column({ type: 'text' })
  question: string;

  @Column('text', { array: true })
  choices: string[];

  @Column({ type: 'text' })
  correctAnswer: string;
}
