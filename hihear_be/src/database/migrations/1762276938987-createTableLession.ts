import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateTableLession1762276938987 implements MigrationInterface {
  name = 'CreateTableLession1762276938987';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "lession" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), "title" character varying NOT NULL, "description" text, "category" character varying(100) NOT NULL, "level" character varying(10) NOT NULL, "duration_seconds" integer NOT NULL DEFAULT '0', "xp_reward" integer NOT NULL DEFAULT '0', "prerequisite_lesson_id" uuid, "created_by_id" uuid, CONSTRAINT "UQ_9ba8c58002872a608e08eee9e45" UNIQUE ("title"), CONSTRAINT "PK_24a20d1f6d03e7a7949252cbd74" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ADD CONSTRAINT "FK_f2ba566fd13a071bcb53ec24ac0" FOREIGN KEY ("prerequisite_lesson_id") REFERENCES "lession"("id") ON DELETE SET NULL ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" ADD CONSTRAINT "FK_4efe13f2bbfa07782641bdc3ba0" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "lession" DROP CONSTRAINT "FK_4efe13f2bbfa07782641bdc3ba0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "lession" DROP CONSTRAINT "FK_f2ba566fd13a071bcb53ec24ac0"`,
    );
    await queryRunner.query(`DROP TABLE "lession"`);
  }
}
