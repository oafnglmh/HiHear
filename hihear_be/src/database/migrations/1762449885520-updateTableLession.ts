import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateTableLession1762449885520 implements MigrationInterface {
  name = 'UpdateTableLession1762449885520';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lession" DROP CONSTRAINT "FK_4efe13f2bbfa07782641bdc3ba0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" DROP COLUMN "created_by_id"`,
    );
    await queryRunner.query(`ALTER TABLE "lession" ADD "user_id" uuid`);
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" SET DEFAULT 'en'`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ALTER COLUMN "category" DROP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ALTER COLUMN "level" DROP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ADD CONSTRAINT "FK_b09192d8479ca058f66ee4e368d" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lession" DROP CONSTRAINT "FK_b09192d8479ca058f66ee4e368d"`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ALTER COLUMN "level" SET NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ALTER COLUMN "category" SET NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" DROP DEFAULT`,
    );
    await queryRunner.query(`ALTER TABLE "lession" DROP COLUMN "user_id"`);
    await queryRunner.query(`ALTER TABLE "lession" ADD "created_by_id" uuid`);
    await queryRunner.query(
      `ALTER TABLE "lession" ADD CONSTRAINT "FK_4efe13f2bbfa07782641bdc3ba0" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
  }
}
