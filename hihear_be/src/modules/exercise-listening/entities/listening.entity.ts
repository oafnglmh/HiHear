import { AbstractEntity } from 'src/common/abstract.entity';
import { Column, Entity, ManyToOne } from 'typeorm';
import { ExercisesEntity } from 'src/modules/exercises/entities/exercises.entity';
import { MediaEntity } from 'src/modules/media/entities/media.entity';

@Entity('listenings')
export class ListeningEntity extends AbstractEntity {
  @ManyToOne(() => MediaEntity, { nullable: false, eager: true })
  media: MediaEntity;

  @Column({ type: 'text', nullable: true })
  transcript: string | null;

  @Column('text', { array: true })
  choices: string[];

  @Column()
  correctAnswer: string;

  @ManyToOne(() => ExercisesEntity, (exercise) => exercise.listenings, {
    onDelete: 'CASCADE',
  })
  exercise: ExercisesEntity;
}
