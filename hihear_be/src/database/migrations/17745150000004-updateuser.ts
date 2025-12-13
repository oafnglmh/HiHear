import { MigrationInterface, QueryRunner } from "typeorm";

export class AddLessonVideoIdToLessons1699999999991 implements MigrationInterface {
    name = 'AddLessonVideoIdToLessons1699999999991';

    public async up(queryRunner: QueryRunner): Promise<void> {
        // Thêm cột lesson_video_id
        await queryRunner.query(`
            ALTER TABLE "lessons" ADD "lesson_video_id" uuid
        `);

        // Thêm foreign key
        await queryRunner.query(`
            ALTER TABLE "lessons"
            ADD CONSTRAINT "FK_lesson_video_id"
            FOREIGN KEY ("lesson_video_id") REFERENCES "lesson_videos"("id")
            ON DELETE SET NULL
            ON UPDATE CASCADE
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Xóa foreign key
        await queryRunner.query(`
            ALTER TABLE "lessons" DROP CONSTRAINT "FK_lesson_video_id"
        `);

        // Xóa cột lesson_video_id
        await queryRunner.query(`
            ALTER TABLE "lessons" DROP COLUMN "lesson_video_id"
        `);
    }
}
