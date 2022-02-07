import 'package:client/ui/screens/splash_screen/splash_screen.dart';
import 'package:client/utils/app_utils.dart';
import 'package:client/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:client/ui/routes/routes_generator.dart' as router;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late bool isAuthenticated;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: theme,
      home: const SplashScreen(),
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
