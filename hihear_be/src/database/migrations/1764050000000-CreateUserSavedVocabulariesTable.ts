import { MigrationInterface, QueryRunner } from 'typeorm';

export class SyncUserSavedVocabulariesTable1733412000000 implements MigrationInterface {
  name = 'SyncUserSavedVocabulariesTable1733412000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE "user_saved_vocabularies" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        "user_id" uuid NOT NULL,
        "word" character varying(100) NOT NULL,
        "meaning" text,
        "category" text,
        CONSTRAINT "UQ_user_saved_vocabularies_user_word" UNIQUE ("user_id", "word"),
        CONSTRAINT "PK_user_saved_vocabularies" PRIMARY KEY ("id")
      )
    `);

    await queryRunner.query(`
      CREATE INDEX "IDX_user_saved_vocabularies_word" 
      ON "user_saved_vocabularies" ("word")
    `);

    await queryRunner.query(`
      ALTER TABLE "user_saved_vocabularies"
      ADD CONSTRAINT "FK_user_saved_vocabularies_user_id"
      FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user_saved_vocabularies" 
      DROP CONSTRAINT "FK_user_saved_vocabularies_user_id"
    `);

    await queryRunner.query(`
      DROP INDEX "public"."IDX_user_saved_vocabularies_word"
    `);

    await queryRunner.query(`DROP TABLE "user_saved_vocabularies"`);
  }
}