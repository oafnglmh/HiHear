// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'HiHear';

  @override
  String get splashTagline => 'AI-powered personalized language learning';

  @override
  String get translLoginGg => 'Sign in with Google';

  @override
  String get translLoginFb => 'Sign in with Facebook';

  @override
  String get translWelcome => 'Welcome to HiHear';

  @override
  String get dailyGoalQuestion => 'What\'s your daily goal?';

  @override
  String get minuteLabel => 'Minute';

  @override
  String get dayLabel => 'Day';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyVeryHard => 'Very Hard';

  @override
  String get nextButton => 'Next';

  @override
  String get startButton => 'Start';

  @override
  String get journeyStartMessage => 'Let\'s start your learning journey!';
}
