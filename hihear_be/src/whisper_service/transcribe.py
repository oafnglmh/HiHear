import whisper
from googletrans import Translator
import subprocess
import sys
import os

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
], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# --- Transcribe tiếng Việt ---
result = model.transcribe(
    wav_file,
    language="vi",
    verbose=False
)

# --- Lấy segment có timestamp ---
translations = []

for seg in result["segments"]:
    start = seg["start"]
    end = seg["end"]
    text_vi = seg["text"].strip()

    if not text_vi:
        continue

    # Dịch
    en = translator.translate(text_vi, src="vi", dest="en").text
    ko = translator.translate(text_vi, src="vi", dest="ko").text

    translations.append(
        f"[{start:.2f}s --> {end:.2f}s]\n"
        f"vi: {text_vi}\n"
        f"en: {en}\n"
        f"ko: {ko}\n"
    )

# --- Xuất kết quả ---
output_text = "\n".join(translations)
print(output_text)

# --- Xoá file tạm ---
os.remove(wav_file)
