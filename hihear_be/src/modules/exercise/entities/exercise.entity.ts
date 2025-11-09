import { AbstractEntity } from 'src/common/abstract.entity';
import { ExerciseType } from 'src/utils/exercise-type.enum';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { Column, Entity, ManyToOne } from 'typeorm';
import { VocabularyContent } from '../domain/vocabulary-content.domain';
import { GrammarContent } from '../domain/gramma-content.domain';
import { ListeningContent } from '../domain/listening-content.domain';
import { SpeakingContent } from '../domain/speaking-content.domain';
import { LessionEntity } from 'src/modules/lession/entities/lession.entity';

@Entity('exercise')
export class ExerciseEntity extends AbstractEntity {
  @ManyToOne(() => LessionEntity, (lesson) => lesson.exercises, {
    onDelete: 'CASCADE',
  })
  lesson: LessionEntity;

  @Column({ type: 'enum', enum: ExerciseType })
  type: ExerciseType;

  @Column({ type: 'enum', enum: LessonCategory })
  category: LessonCategory;

  @Column({ type: 'jsonb' })
  content:
    | VocabularyContent
    | GrammarContent
    | ListeningContent
    | SpeakingContent;

  @Column({ type: 'int', default: 0 })
  points: number;

  @Column({ type: 'text', nullable: true })
  aiFeedback: string;
}
