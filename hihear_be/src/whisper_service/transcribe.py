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
if len(sys.argv) < 2:
    print("Vui lòng cung cấp đường dẫn video.")
    sys.exit(1)

input_file = sys.argv[1]

# --- Convert sang WAV 16kHz mono ---
wav_file = "tmp_audio.wav"
subprocess.run([
    "ffmpeg", "-y", "-i", input_file,
    "-ar", "16000", "-ac", "1", wav_file
])

# --- Transcribe tiếng Việt ---
result = model.transcribe(wav_file, language="vi")
text_vi = result['text'].strip()

# --- Tách câu ---
sentences = re.split(r'(?<=[.!?])\s+', text_vi)

# --- Dịch sang tiếng Anh và Hàn ---
translations = []
for s in sentences:
    if s.strip():
        en = translator.translate(s, src='vi', dest='en').text
        ko = translator.translate(s, src='vi', dest='ko').text
        translations.append(f"vi: {s}\nen: {en}\nko: {ko}\n")

# --- Xuất kết quả ---
output_text = "\n".join(translations)
print(output_text)

# --- Xoá file tạm ---
os.remove(wav_file)
