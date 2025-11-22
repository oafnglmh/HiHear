import sys, os, re, subprocess, json
import whisper
from googletrans import Translator

file_path = sys.argv[1]

wav_file = "tmp_audio.wav"
subprocess.run([
    "ffmpeg", "-y", "-i", file_path,
    "-ar", "16000", "-ac", "1", wav_file
])

model_cache_dir = "./model_cache"
os.makedirs(model_cache_dir, exist_ok=True)
model = whisper.load_model("base", download_root=model_cache_dir)
translator = Translator()


result = model.transcribe(wav_file, language="vi")
text_vi = result['text'].strip()

sentences = re.split(r'(?<=[.!?])\s+', text_vi)
translations = []
for s in sentences:
    if s.strip():
        en = translator.translate(s, src='vi', dest='en').text
        ko = translator.translate(s, src='vi', dest='ko').text
        translations.append({"vi": s, "en": en, "ko": ko})

os.remove(wav_file)

print(json.dumps(translations, ensure_ascii=False))