import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddTableMediaAndUpdateTableLesson1762862062430
  implements MigrationInterface
{
  name = 'AddTableMediaAndUpdateTableLesson1762862062430';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE IF EXISTS "lession" CASCADE`);

    await queryRunner.query(
      `CREATE TYPE "public"."medias_file_type_enum" AS ENUM('audio', 'video', 'image', 'text')`,
    );
    await queryRunner.query(
      `CREATE TABLE "medias" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "file_name" character varying NOT NULL, "file_url" character varying NOT NULL, "file_type" "public"."medias_file_type_enum" NOT NULL, "lesson_id" uuid, CONSTRAINT "PK_f27321557a66cd4fae9bc1ed6e7" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "lessons" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "title" character varying NOT NULL, "description" text, "category" character varying(100), "level" character varying(10), "duration_seconds" integer NOT NULL DEFAULT '0', "xp_reward" integer NOT NULL DEFAULT '0', "prerequisite_lesson_id" uuid, "user_id" uuid, CONSTRAINT "PK_9b9a8d455cac672d262d7275730" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" DROP DEFAULT`,
    );
    await queryRunner.query(
      `ALTER TABLE "medias" ADD CONSTRAINT "FK_58403a3a04e9fbf70f374afe854" FOREIGN KEY ("lesson_id") REFERENCES "lessons"("id") ON DELETE SET NULL ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "lessons" ADD CONSTRAINT "FK_c0962228fcf253d5f45437e7373" FOREIGN KEY ("prerequisite_lesson_id") REFERENCES "lessons"("id") ON DELETE SET NULL ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "lessons" ADD CONSTRAINT "FK_ddd9738993ea215c1b3b4a9977d" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lessons" DROP CONSTRAINT "FK_ddd9738993ea215c1b3b4a9977d"`,
    );
    await queryRunner.query(
      `ALTER TABLE "lessons" DROP CONSTRAINT "FK_c0962228fcf253d5f45437e7373"`,
    );
    await queryRunner.query(
      `ALTER TABLE "medias" DROP CONSTRAINT "FK_58403a3a04e9fbf70f374afe854"`,
    );
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" SET DEFAULT 'en'`,
    );
    await queryRunner.query(`DROP TABLE "lessons"`);
    await queryRunner.query(`DROP TABLE "medias"`);
    await queryRunner.query(`DROP TYPE "public"."medias_file_type_enum"`);
  }
}
