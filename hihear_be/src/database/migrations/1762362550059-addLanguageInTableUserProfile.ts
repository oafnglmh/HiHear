import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddLanguageInTableUserProfile1762362550059
  implements MigrationInterface
{
  name = 'AddLanguageInTableUserProfile1762362550059';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TYPE "public"."user_profiles_language_enum" AS ENUM('en', 'vi', 'ja', 'ko')`,
    );
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ADD "language" "public"."user_profiles_language_enum" DEFAULT 'en'`,
    );
    await queryRunner.query(`ALTER TABLE "user_profiles" DROP COLUMN "level"`);
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ADD "level" character varying`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "user_profiles" DROP COLUMN "level"`);
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ADD "level" character varying(10)`,
    );
    await queryRunner.query(
      `ALTER TABLE "user_profiles" DROP COLUMN "language"`,
    );
    await queryRunner.query(`DROP TYPE "public"."user_profiles_language_enum"`);
  }
}
