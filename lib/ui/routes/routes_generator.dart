import 'package:client/ui/screens/auth_screen/auth_screen.dart';
import 'package:client/ui/screens/home_screen/home_screen.dart';
import 'package:client/ui/screens/profile_screen/profile_screen.dart';
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
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case ProfileScreen.route:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
    }
  }
}
