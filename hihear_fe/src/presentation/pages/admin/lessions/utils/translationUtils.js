export class TranslationService {
  static async translateText(text, targetLangCode) {
    if (!text?.trim() || targetLangCode === "vi") return text;

    try {
      const encodedText = encodeURIComponent(text);
      const url = `https://api.mymemory.translated.net/get?q=${encodedText}&langpair=vi|${targetLangCode}`;
      const response = await fetch(url);
      const data = await response.json();

      return data.responseStatus === 200
        ? data.responseData.translatedText
        : text;
    } catch (error) {
      console.error("Translation error:", error);
      return text;
    }
  }

  static async batchTranslate(texts, targetLangCode) {
    return Promise.all(
      texts.map((text) => this.translateText(text, targetLangCode))
    );
  }

  static async translateVocabulary(questions, langCode) {
    if (langCode === "vi") return questions;

    const allOptions = questions.flatMap((q) => [q.optionA, q.optionB]);
    const translated = await this.batchTranslate(allOptions, langCode);

    return questions.map((q, idx) => ({
      ...q,
      optionA: translated[idx * 2],
      optionB: translated[idx * 2 + 1],
    }));
  }

  static async translateGrammar(examples, langCode) {
    if (langCode === "vi") return examples;

    const meanings = examples.map((ex) => ex.meaning);
    const translated = await this.batchTranslate(meanings, langCode);

    return examples.map((ex, idx) => ({
      ...ex,
      meaning: translated[idx],
    }));
  }
}