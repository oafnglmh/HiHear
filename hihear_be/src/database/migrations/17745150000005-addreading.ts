import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddExerciseReading1763310762981 implements MigrationInterface {
  name = 'AddExerciseReading1763310762981';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "reading" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        "number" character varying NOT NULL,
        "read" character varying NOT NULL,
        "exercise_id" uuid,
        CONSTRAINT "PK_8c7b5d6c5a9f1b3a4d9b8c12345" PRIMARY KEY ("id")
      )`
    );

    await queryRunner.query(
      `ALTER TABLE "reading" ADD CONSTRAINT "FK_reading_exercise" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("id") ON DELETE CASCADE ON UPDATE NO ACTION`
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "reading" DROP CONSTRAINT "FK_reading_exercise"`
    );
    await queryRunner.query(`DROP TABLE "reading"`);
  }
}
