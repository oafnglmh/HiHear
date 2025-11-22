import { Injectable } from '@nestjs/common';
import { spawn } from 'child_process';
import { join } from 'path';

@Injectable()
export class VideoService {
  async transcribe(filePath: string): Promise<any> {
    return new Promise((resolve, reject) => {
      const pyScript = join(__dirname, 'transcribe.py');
      const process = spawn('python3', [pyScript, filePath]);

      let data = '';
      let error = '';

      process.stdout.on('data', (chunk) => data += chunk.toString());
      process.stderr.on('data', (chunk) => error += chunk.toString());

      process.on('close', (code) => {
        if (code !== 0 || error) return reject(error || `Exit code ${code}`);
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          reject(e);
        }
      });
    });
  }
}