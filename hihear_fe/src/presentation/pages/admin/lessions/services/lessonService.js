import { createLesson , editLessonApi, deleteLessonApi } from "../api/lessonApi";

export async function saveLesson(lesson) {
  const payload = {
    title: lesson.title,
    description: lesson.description,
    category: lesson.category ?? null,
    level: lesson.level,
    durationSeconds: lesson.durationSeconds ?? 0,
    xpReward: lesson.xpReward ?? 0,
    prerequisiteLesson: lesson.prerequisiteLesson ?? null,
  };

  const res = await createLesson(payload);
  return res.data;
}

export async function editLesson(lesson, id) {
  const payload = {
    title: lesson.title,
    description: lesson.description,
    category: lesson.category ?? null,
    level: lesson.level,
    durationSeconds: lesson.durationSeconds ?? 0,
    xpReward: lesson.xpReward ?? 0,
    prerequisiteLesson: lesson.prerequisiteLesson ?? null,
  };

  const res = await editLessonApi(payload, id);
  return res.data;
}

export async function deleteLesson(id) {
  const res = await deleteLessonApi(id);
  return res.data;
}
