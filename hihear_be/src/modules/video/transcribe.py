import sys
import io
import os
import re
import subprocess
import json
import whisper
from googletrans import Translator

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "No file path provided"}, ensure_ascii=False))
        sys.exit(1)

    file_path = sys.argv[1]

    if not os.path.exists(file_path):
        print(json.dumps({"error": f"File not found: {file_path}"}, ensure_ascii=False))
        sys.exit(1)

    wav_file = f"tmp_audio_{os.getpid()}.wav"

    try:
        subprocess.run([
            "ffmpeg", "-y", "-i", file_path,
            "-ar", "16000", "-ac", "1", "-acodec", "pcm_s16le",
            wav_file
        ], check=True, capture_output=True)

        model_cache_dir = "./model_cache"
        os.makedirs(model_cache_dir, exist_ok=True)
        model = whisper.load_model("base", download_root=model_cache_dir)

        result = model.transcribe(wav_file, language="vi")
        segments = result.get('segments', [])
        translator = Translator()
        translations = []

        for seg in segments:
            text_vi = seg['text'].strip()
            start_time = seg['start']
            end_time = seg['end']

            sentences = re.split(r'(?<=[.!?])\s+', text_vi)

            for sentence in sentences:
                if sentence.strip():
                    try:
                        en_text = translator.translate(sentence, src='vi', dest='en').text
                        ko_text = translator.translate(sentence, src='vi', dest='ko').text
                    except Exception:
                        en_text = sentence
                        ko_text = sentence

                    translations.append({
                        "vi": sentence,
                        "en": en_text,
                        "ko": ko_text,
                        "start": start_time,
                        "end": end_time
                    })

        print(json.dumps(translations, ensure_ascii=False, indent=2))

    except subprocess.CalledProcessError as e:
        print(json.dumps({"error": f"FFmpeg error: {e.stderr.decode()}"}, ensure_ascii=False))
        sys.exit(1)

    except Exception as e:
        print(json.dumps({"error": f"Processing error: {str(e)}"}, ensure_ascii=False))
        sys.exit(1)

    finally:
        if os.path.exists(wav_file):
            os.remove(wav_file)

if __name__ == "__main__":
    main()
