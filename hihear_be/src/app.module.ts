import { Module } from '@nestjs/common';
import { TypeOrmConfigService } from './database/typeorm-config.service';
import { DataSource } from 'typeorm';
import { TypeOrmModule } from '@nestjs/typeorm';
import { addTransactionalDataSource } from 'typeorm-transactional';
import { SharedModule } from './shared/shared.module';
import { ApiConfigService } from './shared/services/api-config.service';
import { PassportModule } from '@nestjs/passport/dist/passport.module';
import { ConfigModule } from '@nestjs/config';
import { HttpModule } from '@nestjs/axios';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { UserProfilesModule } from './modules/user-profiles/user-profile.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { LessonModule } from './modules/lesson/lesson.module';
import { MediaModule } from './modules/media/media.module';
import { MinioClientModule } from './modules/minio/minio.module';
import { ExercisesModule } from './modules/exercises/exercises.module';
import { ExerciseGrammaModule } from './modules/exercise-gramma/exercise-gramma.module';
import { ExerciseVocabularyModule } from './modules/exercise-vocabulary/exercise-vocabulary.module';
import { VideoModule } from './modules/video/video.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    PassportModule.register({ defaultStrategy: 'jwt' }),
    SharedModule,

    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'public'),
      serveRoot: '/',
    }),

    TypeOrmModule.forRootAsync({
      imports: [SharedModule],
      useClass: TypeOrmConfigService,
      inject: [ApiConfigService],
      dataSourceFactory: (options) => {
        if (!options) {
          throw new Error('Invalid options passed');
        }

        return Promise.resolve(
          addTransactionalDataSource(new DataSource(options)),
        );
      },
    }),
    HttpModule.register({
      timeout: 5000,
      maxRedirects: 5,
    }),
    UsersModule,
    AuthModule,
    UserProfilesModule,
    LessonModule,
    MediaModule,
    MinioClientModule,
    VideoModule,
    ExercisesModule,
    ExerciseGrammaModule,
    ExerciseVocabularyModule,
  ],
})
export class AppModule {}
