import 'package:client/data/models/dummy_data.dart';
import 'package:client/logic/cubit/auth_cubit.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/logic/cubit/user_cubit.dart';
import 'package:client/utils/app_utils.dart';
import 'package:client/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:client/ui/routes/routes_generator.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
  void didChangeDependencies() {
    for (var img in DummyData().cussineList) {
      precacheImage(AssetImage(img['url'] ?? ''), context);
    }
    for (var img in DummyData().restaurantImageList) {
      precacheImage(AssetImage(img), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => RestaurantCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CollectionCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: theme,
        onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}
