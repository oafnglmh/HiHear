import { AbstractEntity } from 'src/common/abstract.entity';
import { Column, Entity, ManyToOne } from 'typeorm';
import { ExercisesEntity } from 'src/modules/exercises/entities/exercises.entity';

@Entity('grammar')
export class GrammarEntity extends AbstractEntity {
  @Column({ type: 'text' })
  grammarRule: string;

  @Column({ type: 'text', nullable: true })
  example: string;

  @Column({ type: 'text', nullable: true })
  meaning: string;

  @ManyToOne(() => ExercisesEntity, (exercise) => exercise.grammars, {
    onDelete: 'CASCADE',
  })
  exercise: ExercisesEntity;
}
