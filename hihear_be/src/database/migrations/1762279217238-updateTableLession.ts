import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateTableLession1762279217238 implements MigrationInterface {
  name = 'UpdateTableLession1762279217238';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lession" DROP CONSTRAINT "UQ_9ba8c58002872a608e08eee9e45"`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lession" ADD CONSTRAINT "UQ_9ba8c58002872a608e08eee9e45" UNIQUE ("title")`,
    );
  }
}
