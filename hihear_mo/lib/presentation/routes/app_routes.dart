import 'package:go_router/go_router.dart';
import 'package:hihear_mo/presentation/pages/Goal/goal_selector_page.dart';
import 'package:hihear_mo/presentation/pages/Goal/level_test_page.dart';
import 'package:hihear_mo/presentation/pages/Goal/start_app_page.dart';
import 'package:hihear_mo/presentation/pages/Goal/test_page.dart';
import 'package:hihear_mo/presentation/pages/country/country_selection_page.dart';
import 'package:hihear_mo/presentation/pages/home/home_page.dart';
import 'package:hihear_mo/presentation/pages/lession/grammar/grammar_lesson_page.dart';
import 'package:hihear_mo/presentation/pages/lession/vocabulary/vocab_lesson_page.dart';
import 'package:hihear_mo/presentation/pages/login/login_page.dart';
import 'package:hihear_mo/presentation/pages/profile/profile_page.dart';
import 'package:hihear_mo/presentation/pages/setting/about_page.dart';
import 'package:hihear_mo/presentation/pages/setting/help_page.dart';
import 'package:hihear_mo/presentation/pages/setting/language_setting_page.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import 'package:hihear_mo/presentation/pages/speak/speaking_lesson_page.dart';
import 'package:hihear_mo/presentation/pages/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const goalSelector = '/goalSelector';
  static const start = '/start';
  static const chooseLanguageTest = '/chooseLanguageTest';
  static const test = '/test';
  static const about = '/about';
  static const help = '/help';
  static const language = '/language';
  static const setting = '/setting';
  static const speak = '/speak';
  static const speaking = '/speaking';
  static const profile = '/profile';
  static const languageCountry = '/languageCountry';
  static const vocab = '/vocab/:id';
  static const grammar = '/grammar/:id';
}

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        final loggingIn = state.matchedLocation == AppRoutes.login;

        if ((token == null || token.isEmpty) && !loggingIn) {
          return AppRoutes.login;
        } else if (token != null && token.isNotEmpty && loggingIn) {
          return AppRoutes.home;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.goalSelector,
          name: 'goalSelector',
          builder: (context, state) => const StudyTimePage(),
        ),
        GoRoute(
          path: AppRoutes.start,
          name: 'start',
          builder: (context, state) => const StartPage(),
        ),
        GoRoute(
          path: AppRoutes.about,
          name: 'about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: AppRoutes.help,
          name: 'help',
          builder: (context, state) => const HelpPage(),
        ),
        GoRoute(
          path: AppRoutes.language,
          name: 'language',
          builder: (context, state) => const LanguageSettingPage(),
        ),
        GoRoute(
          path: AppRoutes.speak,
          name: 'speak',
          builder: (context, state) => const SpeakPage(),
        ),
        GoRoute(
          path: AppRoutes.speaking,
          name: 'speaking',
          builder: (context, state) => const SpeakingLessonPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: AppRoutes.languageCountry,
          name: 'languageCountry',
          builder: (context, state) => const CountrySelectionPage(),
        ),
        GoRoute(
          path: AppRoutes.vocab,
          name: 'vocab',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return VocabLessonPage(id: id);
          },
        ),
        GoRoute(
          path: AppRoutes.grammar,
          name: 'grammar',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return GrammarLessonPage(id: id);
          },
        ),
        GoRoute(
          path: AppRoutes.chooseLanguageTest,
          name: 'chooseLanguageTest',
          builder: (context, state) {
            return LanguageSelectionScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.test,
          name: 'test',
          builder: (context, state) {
            var language = state.extra as String?;
            language ??= "english";
            return TestScreen(language: language);
          },
        ),
      ],
    );
  }
}
