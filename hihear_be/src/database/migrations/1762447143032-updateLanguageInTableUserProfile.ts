import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateLanguageInTableUserProfile1762447143032
  implements MigrationInterface
{
  name = 'UpdateLanguageInTableUserProfile1762447143032';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" DROP DEFAULT`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "user_profiles" ALTER COLUMN "language" SET DEFAULT 'en'`,
    );
  }
}
