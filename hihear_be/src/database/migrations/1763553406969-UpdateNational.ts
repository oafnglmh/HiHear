import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateNational1763553406969 implements MigrationInterface {
  name = 'UpdateNational1763553406969';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" ALTER COLUMN "media_id" DROP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TYPE "public"."exercises_national_enum" RENAME TO "exercises_national_enum_old"`,
    );
    await queryRunner.query(
      `CREATE TYPE "public"."exercises_national_enum" AS ENUM('Vietnam', 'Korea', 'UK')`,
    );
    await queryRunner.query(
      `ALTER TABLE "exercises" ALTER COLUMN "national" TYPE "public"."exercises_national_enum" USING "national"::"text"::"public"."exercises_national_enum"`,
    );
    await queryRunner.query(`DROP TYPE "public"."exercises_national_enum_old"`);
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0" FOREIGN KEY ("media_id") REFERENCES "medias"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0"`,
    );
    await queryRunner.query(
      `CREATE TYPE "public"."exercises_national_enum_old" AS ENUM('Vietnam', 'USA', 'UK')`,
    );
    await queryRunner.query(
      `ALTER TABLE "exercises" ALTER COLUMN "national" TYPE "public"."exercises_national_enum_old" USING "national"::"text"::"public"."exercises_national_enum_old"`,
    );
    await queryRunner.query(`DROP TYPE "public"."exercises_national_enum"`);
    await queryRunner.query(
      `ALTER TYPE "public"."exercises_national_enum_old" RENAME TO "exercises_national_enum"`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" ALTER COLUMN "media_id" SET NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0" FOREIGN KEY ("media_id") REFERENCES "medias"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
