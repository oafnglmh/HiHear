import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateUserLessonProgressTable1773515000001 implements MigrationInterface {
  name = 'CreateUserLessonProgressTable1773515000001';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE "user_lesson_progress" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        "user_id" uuid NOT NULL,
        "lesson_id" uuid NOT NULL,
        "completed" boolean NOT NULL DEFAULT false,
        "completed_at" TIMESTAMP,
        CONSTRAINT "UQ_user_lesson" UNIQUE ("user_id", "lesson_id"),
        CONSTRAINT "PK_user_lesson_progress" PRIMARY KEY ("id")
      )
    `);

    await queryRunner.query(`
      CREATE INDEX "IDX_user_lesson_progress_user_id"
      ON "user_lesson_progress" ("user_id")
    `);

    await queryRunner.query(`
      CREATE INDEX "IDX_user_lesson_progress_lesson_id"
      ON "user_lesson_progress" ("lesson_id")
    `);

    await queryRunner.query(`
      ALTER TABLE "user_lesson_progress"
      ADD CONSTRAINT "FK_user_lesson_progress_user_id"
      FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
    `);

    await queryRunner.query(`
      ALTER TABLE "user_lesson_progress"
      ADD CONSTRAINT "FK_user_lesson_progress_lesson_id"
      FOREIGN KEY ("lesson_id") REFERENCES "lessons"("id") ON DELETE CASCADE
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user_lesson_progress" 
      DROP CONSTRAINT "FK_user_lesson_progress_user_id"
    `);

    await queryRunner.query(`
      ALTER TABLE "user_lesson_progress" 
      DROP CONSTRAINT "FK_user_lesson_progress_lesson_id"
    `);

    await queryRunner.query(`
      DROP INDEX "public"."IDX_user_lesson_progress_user_id"
    `);

    await queryRunner.query(`
      DROP INDEX "public"."IDX_user_lesson_progress_lesson_id"
    `);

    await queryRunner.query(`DROP TABLE "user_lesson_progress"`);
  }
}
