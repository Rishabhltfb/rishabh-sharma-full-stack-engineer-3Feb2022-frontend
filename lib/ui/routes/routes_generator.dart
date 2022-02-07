import 'package:client/ui/screens/auth_screen/auth_screen.dart';
import 'package:client/ui/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AuthScreen.route:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
    }
  }
}
