import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { spawn } from 'child_process';
import { join } from 'path';
import { unlink } from 'fs/promises';

@Injectable()
export class VideoService {
  async transcribe(filePath: string): Promise<any> {
    return new Promise((resolve, reject) => {
      const pyScript = join(__dirname, 'transcribe.py');
      const process = spawn('python', [pyScript, filePath]);

      let data = '';
      let error = '';

      process.stdout.on('data', (chunk) => {
        data += chunk.toString();
      });

      process.stderr.on('data', (chunk) => {
        const text = chunk.toString();

        if (
          text.includes("FP16 is not supported on CPU") ||
          text.toLowerCase().includes("userwarning") ||
          text.toLowerCase().includes("warning")
        ) {
          console.warn("Whisper Warning:", text);
          return;
        }

        error += text;
      });

      process.on('close', async (code) => {
        try {
          await unlink(filePath);
        } catch (err) {
          console.error('Failed to delete temp file:', err);
        }

        if (code !== 0 && error.trim() !== '') {
          console.error('Python script error:', error);
          return reject(
            new InternalServerErrorException(
              error || `Process exited with code ${code}`
            )
          );
        }

        try {
          const result = JSON.parse(data);
          resolve(result);
        } catch (e) {
          console.error('Failed to parse JSON:', data);
          reject(
            new InternalServerErrorException(
              'Failed to parse transcription result'
            )
          );
        }
      });

      process.on('error', (err) => {
        reject(
          new InternalServerErrorException(
            `Failed to start Python process: ${err.message}`
          )
        );
      });
    });
  }
}
