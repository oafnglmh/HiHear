import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddExerciseVocabulay1763282473133 implements MigrationInterface {
  name = 'AddExerciseVocabulay1763282473133';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "vocabularies" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "question" text NOT NULL, "choices" text array NOT NULL, "correct_answer" text NOT NULL, "exercise_id" uuid, CONSTRAINT "PK_1f0c8d5539ccaf456ebf73cabb5" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TYPE "public"."exercises_type_enum" AS ENUM('mcq', 'listening', 'fill_blank', 'speaking', 'reading', 'writing')`,
    );
    await queryRunner.query(
      `CREATE TYPE "public"."exercises_national_enum" AS ENUM('Vietnam', 'USA', 'UK')`,
    );
    await queryRunner.query(
      `CREATE TABLE "exercises" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "type" "public"."exercises_type_enum" NOT NULL, "points" integer NOT NULL DEFAULT '0', "national" "public"."exercises_national_enum", "lesson_id" uuid, CONSTRAINT "PK_c4c46f5fa89a58ba7c2d894e3c3" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(`ALTER TABLE "lessons" DROP COLUMN "category"`);
    await queryRunner.query(
      `CREATE TYPE "public"."lessons_category_enum" AS ENUM('Từ vựng', 'Ngữ pháp', 'Nghe hiểu', 'Nói', 'Đọc hiểu', 'Viết')`,
    );
    await queryRunner.query(
      `ALTER TABLE "lessons" ADD "category" "public"."lessons_category_enum" NOT NULL DEFAULT 'Từ vựng'`,
    );
    await queryRunner.query(
      `ALTER TABLE "vocabularies" ADD CONSTRAINT "FK_e1927967fc66511ad15e51b0179" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "exercises" ADD CONSTRAINT "FK_26718d98059c38459d2c64ec824" FOREIGN KEY ("lesson_id") REFERENCES "lessons"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "exercises" DROP CONSTRAINT "FK_26718d98059c38459d2c64ec824"`,
    );
    await queryRunner.query(
      `ALTER TABLE "vocabularies" DROP CONSTRAINT "FK_e1927967fc66511ad15e51b0179"`,
    );
    await queryRunner.query(`ALTER TABLE "lessons" DROP COLUMN "category"`);
    await queryRunner.query(`DROP TYPE "public"."lessons_category_enum"`);
    await queryRunner.query(
      `ALTER TABLE "lessons" ADD "category" character varying(100)`,
    );
    await queryRunner.query(`DROP TABLE "exercises"`);
    await queryRunner.query(`DROP TYPE "public"."exercises_national_enum"`);
    await queryRunner.query(`DROP TYPE "public"."exercises_type_enum"`);
    await queryRunner.query(`DROP TABLE "vocabularies"`);
  }
}
