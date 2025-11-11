import { Injectable } from '@nestjs/common';
import { isNil } from '@nestjs/common/utils/shared.utils';
import { ConfigService } from '@nestjs/config';

export interface IBlobConfig {
  connectionString: string;
}

@Injectable()
export class ApiConfigService {
  constructor(private configService: ConfigService) {}

  get apiDomain(): string {
    return this.getString('API_DOMAIN');
  }

  get apiPrefix(): string {
    return this.getString('API_PREFIX');
  }

  get jwtSecret(): string {
    return this.getString('JWT_SECRET');
  }

  get dbConfig() {
    const prod = this.isProduction;

    return {
      host: this.getString('DB_HOST'),
      port: this.getNumber('DB_PORT'),
      username: this.getString('DB_USERNAME'),
      password: this.getString('DB_PASSWORD'),
      database: this.getString('DB_DATABASE'),
      logging: this.getBoolean('ENABLE_ORM_LOGS'),
      ssl: prod ? { rejectUnauthorized: false } : false,
    };
  }

  get googleConfig() {
    return {
      clientIds: this.getStringArray('GOOGLE_CLIENT_IDS'),
    };
  }

  get imageService() {
    return {
      storeDirectory: this.getString('IMAGE_DIRECTORY'),
      imageLimitSize: this.getNumber('IMAGE_LIMIT_SIZE'),
    };
  }

  get serverPort(): number {
    return this.getNumber('PORT');
  }

  get logLevel(): string {
    return this.getString('LOG_LEVEL');
  }

  get isDevelopment(): boolean {
    return this.nodeEnv === 'dev' || this.nodeEnv === 'development';
  }

  get isProduction(): boolean {
    return this.nodeEnv === 'prod' || this.nodeEnv === 'production';
  }

  get enableSwagger(): boolean {
    return this.getBoolean('ENABLE_DOCUMENTATION');
  }

  get nodeEnv(): string {
    return this.getString('NODE_ENV');
  }

  get minioConfig() {
    const endPoint = this.getString('MINIO_ENDPOINT');
    const useSSL = this.get('MINIO_USE_SSL') === 'true';
    const accessKey = this.getString('MINIO_ACCESS_KEY');
    const secretKey = this.getString('MINIO_SECRET_KEY');
    const port = this.getNumber('MINIO_PORT');
    const bucketName = this.getString('MINIO_BUCKET_NAME');
    const url = `${useSSL ? 'https' : 'http'}://${endPoint}:${port}/${bucketName}/`;
    return {
      endPoint,
      port,
      accessKey,
      secretKey,
      useSSL,
      bucketName,
      url,
    };
  }

  private getStringArray(key: string): string[] {
    const value = this.get(key);

    try {
      return JSON.parse(value) as string[];
    } catch {
      return [];
    }
  }

  private getNumber(key: string): number {
    const value = this.getString(key);

    try {
      return Number(value);
    } catch {
      throw new Error(key + ' environment variable is not a number');
    }
  }

  private getBoolean(key: string): boolean {
    const value = this.getString(key);

    try {
      return Boolean(JSON.parse(value));
    } catch {
      throw new Error(key + ' env var is not a boolean');
    }
  }

  private getString(key: string): string {
    const value = this.get(key);

    return value.replaceAll('\\n', '\n');
  }

  private get(key: string): string {
    const value = this.configService.get<string>(key);

    if (!value || isNil(value)) {
      throw new Error(key + ' environment variable does not set');
    }

    return value;
  }
}
