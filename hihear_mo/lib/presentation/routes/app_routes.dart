import 'package:flutter/material.dart';
import 'package:hihear_mo/presentation/pages/Goal/goal_selector_page.dart';
import 'package:hihear_mo/presentation/pages/setting/about_page.dart';
import 'package:hihear_mo/presentation/pages/setting/help_page.dart';
import 'package:hihear_mo/presentation/pages/setting/language_setting_page.dart';
import 'package:hihear_mo/presentation/pages/setting/setting_page.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/login/login_page.dart';
import '../pages/Goal/start_app_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String goalSelector = '/goalSelector';
  static const String start = '/start';
  static const String aboutPage = '/aboutPage';
  static const String helpPage = '/helpPage';
  static const String languagePage = '/languagePage';
  static const String profile = '/profile';
  static const String setting = '/setting';
  static const String speak = '/speak';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case goalSelector:
        return MaterialPageRoute(builder: (_) => const StudyTimePage());
      case start:
        return MaterialPageRoute(builder: (_) => const StartPage());
      case aboutPage:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case helpPage:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case languagePage:
        return MaterialPageRoute(builder: (_) => const LanguageSettingPage());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      case speak:
        return MaterialPageRoute(builder: (_) => const SpeakPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("404 - Page Not Found"))),
        );
    }
  }
}
