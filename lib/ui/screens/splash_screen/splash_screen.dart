import 'dart:developer';

import 'package:client/logic/cubit/auth_cubit.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/logic/cubit/user_cubit.dart';
import 'package:client/ui/screens/auth_screen/auth_screen.dart';
import 'package:client/ui/screens/home_screen/home_screen.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthCubit authCubit;
  late CollectionCubit collectionCubit;
  late UserCubit userCubit;
  late RestaurantCubit restaurantCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    collectionCubit = BlocProvider.of<CollectionCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
    restaurantCubit = BlocProvider.of<RestaurantCubit>(context);
    Future.delayed(const Duration(seconds: 1), () {
      Future.wait([
        authCubit.isAuthenticated(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) {
          if (current is AuthLoaded) {
            return true;
          }
          return false;
        },
        listener: (context, state) async {
          if (state is AuthLoaded) {
            bool isTokenValid = state.isAuthenticated;
            Future.delayed(const Duration(seconds: 4)).then((value) {
              if (isTokenValid) {
                Future.wait([
                  restaurantCubit.fetchAllRestaurants(),
                  userCubit.getUser(),
                  collectionCubit.getUserCollections(),
                ]);
                Navigator.of(context).pushReplacementNamed(HomeScreen.route);
              } else {
                Navigator.of(context).pushReplacementNamed(AuthScreen.route);
              }
            });
          }
        },
        child: Container(
          height: height,
          width: width,
          color: Colors.black,
          child: Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(RestaurantAssets.splashLottieIcon,
                  reverse: true),
            ),
          ),
        ),
      ),
    );
  }
}
