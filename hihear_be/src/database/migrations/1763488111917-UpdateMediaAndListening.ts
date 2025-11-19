import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateMediaAndListening1763488111917
  implements MigrationInterface
{
  name = 'UpdateMediaAndListening1763488111917';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD "media_id" uuid NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0" FOREIGN KEY ("media_id") REFERENCES "medias"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0"`,
    );
    await queryRunner.query(`ALTER TABLE "listenings" DROP COLUMN "media_id"`);
  }
}
