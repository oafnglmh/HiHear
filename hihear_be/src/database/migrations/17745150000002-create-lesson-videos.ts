import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateLessonVideos1700000000000
  implements MigrationInterface
{
  name = 'CreateLessonVideos1700000000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE "lesson_videos" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "fileName" character varying NOT NULL,
        "fileSize" character varying NOT NULL,
        "videoUrl" text NOT NULL,
        "cloudinaryId" character varying NOT NULL,
        "duration" double precision NOT NULL DEFAULT 0,
        "transcriptions" jsonb NOT NULL,
        "lesson_id" uuid,
        "createdAt" TIMESTAMP NOT NULL DEFAULT now(),
        "updatedAt" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_lesson_videos" PRIMARY KEY ("id"),
        CONSTRAINT "FK_lesson_video_lesson"
          FOREIGN KEY ("lesson_id")
          REFERENCES "lessons"("id")
          ON DELETE CASCADE
      )
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE "lesson_videos"`);
  }
}
