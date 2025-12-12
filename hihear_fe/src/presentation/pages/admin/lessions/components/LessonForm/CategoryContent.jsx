import { LESSON_CATEGORIES } from "../../constants/lessonConstants";
import { GrammarForm } from "../CategoryForms/GrammarForm";
import { PronunciationForm } from "../CategoryForms/PronunciationForm";
import { VideoForm } from "../CategoryForms/VideoForm";
import { VocabularyForm } from "../CategoryForms/VocabularyForm";
import { ListeningForm } from "./ListeningForm";

export const CategoryContent = ({ category, formData, updateField }) => {
  const categoryComponents = {
    [LESSON_CATEGORIES.VOCABULARY]: (
      <VocabularyForm
        questions={formData.questions}
        onChange={(questions) => updateField("questions", questions)}
      />
    ),
    [LESSON_CATEGORIES.GRAMMAR]: (
      <GrammarForm
        examples={formData.grammarExamples}
        onChange={(examples) => updateField("grammarExamples", examples)}
      />
    ),
    [LESSON_CATEGORIES.PRONUNCIATION]: (
      <PronunciationForm
        examples={formData.pronunciationExamples}
        order={formData.pronunciationOrder}
        onExamplesChange={(examples) =>
          updateField("pronunciationExamples", examples)
        }
        onOrderChange={(order) => updateField("pronunciationOrder", order)}
      />
    ),
    [LESSON_CATEGORIES.LISTENING]: (
      <ListeningForm
        listenings={formData.listenings}
        onChange={(listenings) => updateField("listenings", listenings)}
      />
    ),
    [LESSON_CATEGORIES.VIDEO]: (
      <VideoForm
        videoData={formData.videoData}
        onChange={(videoData) => updateField("videoData", videoData)}
      />
    ),
  };

  return categoryComponents[category] || null;
};