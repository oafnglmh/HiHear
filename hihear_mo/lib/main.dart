import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/datasources/lession_remote_date_source.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/data/repositories/country_repository_impl.dart';
import 'package:hihear_mo/data/repositories/lession_repository_impl.dart';
import 'package:hihear_mo/domain/repositories/lession_repository.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/blocs/country/country_bloc.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_bloc.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'core/constants/app_colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());
  final countryRepository = CountryRepositoryImpl(AuthRemoteDataSource());
  final lessonRepository = LessionRepositoryImpl(LessionRemoteDataSource());
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepositoryImpl>.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LanguageBloc()),
          BlocProvider(create: (_) => VocabBloc()),
          BlocProvider(create: (context) => AuthBloc(authRepository)),
          BlocProvider(
          create: (_) => CountryBloc(countryRepository),
        ),
          BlocProvider(create: (_) => LessonBloc(repository: lessonRepository))
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
