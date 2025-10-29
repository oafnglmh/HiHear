import whisper
from googletrans import Translator
import subprocess
import sys
import os
import re

# --- Khởi tạo model và translator ---
model_cache_dir = "./model_cache"
os.makedirs(model_cache_dir, exist_ok=True)
model = whisper.load_model("base", download_root=model_cache_dir)
translator = Translator()

# --- File đầu vào ---
input_file = sys.argv[1]

# --- Convert sang WAV 16kHz mono ---
wav_file = "tmp_audio.wav"
subprocess.run([
    "ffmpeg", "-y", "-i", input_file,
    "-ar", "16000", "-ac", "1", wav_file
])

# --- Transcribe tiếng Anh ---
result = model.transcribe(wav_file)
text_en = result['text']

# --- Tách câu và dịch sang tiếng Việt ---
sentences = re.split(r'(?<=[.!?])\s+', text_en)
translations = []
for s in sentences:
    if s.strip():
        vi = translator.translate(s, src='en', dest='vi').text
        translations.append(f"en: {s}, vi: {vi}")

# --- Xuất kết quả ---
output_text = "\n".join(translations)
print(output_text)

# --- Xoá file tạm ---
os.remove(wav_file)
