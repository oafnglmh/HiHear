export class TranslationService {
  static async translateText(text, targetLangCode) {
    if (!text?.trim() || targetLangCode === "vi") return text;

    try {
      const encodedText = encodeURIComponent(text);
      const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=vi&tl=${targetLangCode}&dt=t&q=${encodedText}`;
      
      const response = await fetch(url);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      
      if (data && data[0] && data[0][0] && data[0][0][0]) {
        return data[0][0][0];
      }
      
      console.warn("Translation failed: unexpected response format");
      return text;
      
    } catch (error) {
      console.error("Translation error:", error);
      return text;
    }
  }

  static async batchTranslate(texts, targetLangCode) {
    if (targetLangCode === "vi") return texts;
    
    const results = [];
    
    for (let i = 0; i < texts.length; i++) {
      const translated = await this.translateText(texts[i], targetLangCode);
      results.push(translated);

      if (i < texts.length - 1) {
        await new Promise(resolve => setTimeout(resolve, 100));
      }
    }
    
    return results;
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