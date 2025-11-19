import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateExerciseListeningAndMedia1763474538925
  implements MigrationInterface
{
  name = 'UpdateExerciseListeningAndMedia1763474538925';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "medias" DROP CONSTRAINT "FK_3bb78f8b33080ea5a13708ffa78"`,
    );
    await queryRunner.query(
      `ALTER TABLE "listenings" DROP CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0"`,
    );
    await queryRunner.query(`ALTER TABLE "medias" DROP COLUMN "listening_id"`);
    await queryRunner.query(`ALTER TABLE "listenings" DROP COLUMN "media_id"`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD "media_id" uuid NOT NULL`,
    );
    await queryRunner.query(`ALTER TABLE "medias" ADD "listening_id" uuid`);
    await queryRunner.query(
      `ALTER TABLE "listenings" ADD CONSTRAINT "FK_4e3c15ed1b71a5e5078b114ccf0" FOREIGN KEY ("media_id") REFERENCES "medias"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "medias" ADD CONSTRAINT "FK_3bb78f8b33080ea5a13708ffa78" FOREIGN KEY ("listening_id") REFERENCES "listenings"("id") ON DELETE SET NULL ON UPDATE NO ACTION`,
    );
  }
}
