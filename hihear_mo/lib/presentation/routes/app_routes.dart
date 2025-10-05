import 'package:flutter/material.dart';
import 'package:hihear_mo/presentation/pages/Goal/goal_selector_page.dart';
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
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("404 - Page Not Found"))),
        );
    }
  }
}
