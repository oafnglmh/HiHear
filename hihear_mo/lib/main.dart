import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/repositories/auth_repository_impl.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_bloc.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'core/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HiHearApp());
}

class HiHearApp extends StatelessWidget {
  const HiHearApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => VocabBloc()),
        BlocProvider(create: (_) => AuthBloc(authRepository))
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: "HiHear",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
            ),
            initialRoute: AppRouter.splash,
            onGenerateRoute: AppRouter.generateRoute,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('vi')],
          );
        },
      ),
    );
  }
}
