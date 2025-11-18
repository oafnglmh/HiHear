import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddTableExerciseListening1763447194421
  implements MigrationInterface
{
  name = 'AddTableExerciseListening1763447194421';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "listenings" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "transcript" text, "choices" text array NOT NULL, "correct_answer" character varying NOT NULL, "media_id" uuid NOT NULL, "exercise_id" uuid, CONSTRAINT "PK_d4044732b865564a1ab60d580e2" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(`ALTER TABLE "medias" ADD "listening_id" uuid`);
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0" FOREIGN KEY ("media_id") REFERENCES "medias"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_d5d3b96dd3325a853963910d0b7" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "medias" ADD CONSTRAINT "FK_3bb78f8b33080ea5a13708ffa78" FOREIGN KEY ("listening_id") REFERENCES "listenings"("id") ON DELETE SET NULL ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "medias" DROP CONSTRAINT "FK_3bb78f8b33080ea5a13708ffa78"`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_d5d3b96dd3325a853963910d0b7"`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0"`,
    );
    await queryRunner.query(`ALTER TABLE "medias" DROP COLUMN "listening_id"`);
    await queryRunner.query(`DROP TABLE "listenings"`);
  }
}
