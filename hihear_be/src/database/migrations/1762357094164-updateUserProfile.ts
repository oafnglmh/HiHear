import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateUserProfile1762357094164 implements MigrationInterface {
  name = 'UpdateUserProfile1762357094164';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "user_profiles" DROP COLUMN "level"`);
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ADD "level" character varying(10)`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "user_profiles" DROP COLUMN "level"`);
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ADD "level" character varying`,
    );
  }
}
