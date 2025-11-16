import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddExerciseGrammar1763310762980 implements MigrationInterface {
  name = 'AddExerciseGrammar1763310762980';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "grammar" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "grammar_rule" text NOT NULL, "example" text, "meaning" text, "exercise_id" uuid, CONSTRAINT "PK_b50f592dae837add9d21805db3f" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "grammar" ADD CONSTRAINT "FK_251a52833c040117c99f0a652d3" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "grammar" DROP CONSTRAINT "FK_251a52833c040117c99f0a652d3"`,
    );
    await queryRunner.query(`DROP TABLE "grammar"`);
  }
}
