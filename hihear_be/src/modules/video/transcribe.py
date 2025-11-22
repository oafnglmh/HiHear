import sys
import os
import re
import subprocess
import json
import whisper
from googletrans import Translator

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "No file path provided"}))
        sys.exit(1)
    
    file_path = sys.argv[1]
    
    if not os.path.exists(file_path):
        print(json.dumps({"error": f"File not found: {file_path}"}))
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
        text_vi = result['text'].strip()

        sentences = re.split(r'(?<=[.!?])\s+', text_vi)
        
        translator = Translator()
        
        translations = []
        for sentence in sentences:
            if sentence.strip():
                try:
                    en_translation = translator.translate(sentence, src='vi', dest='en')
                    en_text = en_translation.text
                    
                    ko_translation = translator.translate(sentence, src='vi', dest='ko')
                    ko_text = ko_translation.text
                    
                    translations.append({
                        "vi": sentence,
                        "en": en_text,
                        "ko": ko_text
                    })
                except Exception as e:
                
                    translations.append({
                        "vi": sentence,
                        "en": sentence,
                        "ko": sentence
                    })
        
        print(json.dumps(translations, ensure_ascii=False))
        
    except subprocess.CalledProcessError as e:
        print(json.dumps({"error": f"FFmpeg error: {e.stderr.decode()}"}))
        sys.exit(1)
    except Exception as e:
        print(json.dumps({"error": f"Processing error: {str(e)}"}))
        sys.exit(1)
    finally:
        if os.path.exists(wav_file):
            os.remove(wav_file)

if __name__ == "__main__":
    main()