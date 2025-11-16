import { AbstractEntity } from 'src/common/abstract.entity';
import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { Column, Entity, ManyToOne, OneToMany } from 'typeorm';
import { LessonEntity } from 'src/modules/lesson/entities/lesson.entity';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { VocabularyEntity } from 'src/modules/exercise-vocabulary/entities/vocabulary.entity';

@Entity('exercises')
export class ExercisesEntity extends AbstractEntity {
  @ManyToOne(() => LessonEntity, (lesson) => lesson.exercises, {
    onDelete: 'CASCADE',
    nullable: true,
  })
  lesson: LessonEntity | null;

  @Column({ type: 'enum', enum: ExerciseType })
  type: ExerciseType;

  @Column({ type: 'int', default: 0 })
  points: number;

  @Column({ type: 'enum', enum: Nationality, nullable: true })
  national: Nationality;

  @OneToMany(() => VocabularyEntity, (vocabularies) => vocabularies.exercise, {
    cascade: true,
    eager: true,
  })
  vocabularies: VocabularyEntity[];

  // @OneToMany(() => GrammarEntity, (g) => g.exercise, { cascade: true })
  // grammars?: GrammarEntity[];

  // @OneToMany(() => ListeningEntity, (l) => l.exercise, { cascade: true })
  // listenings?: ListeningEntity[];

  // @OneToMany(() => SpeakingEntity, (s) => s.exercise, { cascade: true })
  // speakings?: SpeakingEntity[];
}
