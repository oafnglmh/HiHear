import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/routes/app_routes.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const HiHearApp());
}

class HiHearApp extends StatelessWidget {
  const HiHearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HiHear",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'), Locale('vi')],
    );
  }
}
