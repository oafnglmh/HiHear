import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hihear_mo/data/datasources/ai_gemini_remote_data_source.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/datasources/lession_remote_date_source.dart';
import 'package:hihear_mo/data/repositories/ai_chat_repository_impl.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/data/repositories/country_repository_impl.dart';
import 'package:hihear_mo/data/repositories/lession_repository_impl.dart';
import 'package:hihear_mo/domain/repositories/ai_chat_repository.dart';
import 'package:hihear_mo/domain/usecases/get_ai_response.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/blocs/ai/ai_chat_cubit.dart';
import 'package:hihear_mo/presentation/blocs/country/country_bloc.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/blocs/save_vocab/save_vocab_bloc.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'core/constants/app_colors.dart';
import 'firebase_options.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env', mergeWith: {});
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ===== Data Sources =====
  final aiRemoteDataSource = AiRemoteDataSource(
    apiKey: dotenv.env['GOOGLE_AI_API_KEY'] ?? '',
    apiUrl: dotenv.env['GOOGLE_AI_API_URL'] ?? '',
  );

  // ===== Repositories =====
  final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());
  final countryRepository = CountryRepositoryImpl(AuthRemoteDataSource());
  final lessonRepository = LessionRepositoryImpl(LessionRemoteDataSource());
  final aiChatRepository = AiChatRepositoryImpl(aiRemoteDataSource);

  // ===== Use Cases =====
  final getAiResponse = GetAiResponse(aiChatRepository);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepositoryImpl>.value(value: authRepository),
        RepositoryProvider<AiChatRepository>.value(value: aiChatRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LanguageBloc()),
         // BlocProvider(create: (_) => VocabBloc()),
          BlocProvider(create: (context) => AuthBloc(authRepository)),
          BlocProvider(create: (_) => CountryBloc(countryRepository)),
          BlocProvider(create: (_) => LessonBloc(repository: lessonRepository)),
          BlocProvider(create: (_) => AiChatCubit(getAiResponse)),
          BlocProvider(create: (_) => SaveVocabBloc(repository: lessonRepository)),
        ],
        child: const HiHearApp(),
      ),
    ),
  );
}

class HiHearApp extends StatelessWidget {
  const HiHearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final router = AppRouter.createRouter();

        return MaterialApp.router(
          title: 'HiHear',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.background,
          ),
          routerConfig: router,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
        );
      },
    );
  }
}
