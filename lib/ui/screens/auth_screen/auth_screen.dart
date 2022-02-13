import 'dart:developer';

import 'package:client/data/models/auth_body.dart';
import 'package:client/logic/cubit/auth_cubit.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/logic/cubit/user_cubit.dart';
import 'package:client/ui/common_widgets/custom_button.dart';
import 'package:client/ui/screens/auth_screen/components/auth_text_field.dart';
import 'package:client/ui/screens/home_screen/home_screen.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  static const String route = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ValueNotifier<bool> _emailValidated = ValueNotifier(false);
  final ValueNotifier<bool> _passwordValidated = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> email = ValueNotifier('');
  final ValueNotifier<String> password = ValueNotifier('');
  late AuthCubit authCubit;
  late CollectionCubit collectionCubit;
  late UserCubit userCubit;
  late RestaurantCubit restaurantCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    collectionCubit = BlocProvider.of<CollectionCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
    restaurantCubit = BlocProvider.of<RestaurantCubit>(context);
  }

  @override
  void dispose() {
    _emailValidated.dispose();
    _passwordValidated.dispose();
    email.dispose();
    isLoading.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = getViewportHeight(context);
    double width = getDeviceWidth(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                bgImage(height, width),
                mask(height, width),
                body(height, width, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned body(double height, double width, BuildContext context) {
    Widget spacer = const SizedBox(height: 16);
    return Positioned(
      bottom: height * 0.1,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            headerWidget(),
            spacer,
            spacer,
            Text(
              'You will get your favourite food here.',
              style: kTitle2.copyWith(color: Colors.white),
            ),
            SizedBox(height: height * 0.2),
            ValueListenableBuilder(
              valueListenable: _emailValidated,
              builder: (context, value, child) => SizedBox(
                width: width * 0.8,
                child: AuthTextField(
                    title: 'Email Address',
                    hintText: 'Please enter your email',
                    onChanged: (String value) {
                      email.value = value;
                    }),
              ),
            ),
            spacer,
            spacer,
            SizedBox(
              width: width * 0.8,
              child: AuthTextField(
                title: 'Password',
                hintText: 'Please enter password',
                onChanged: (String value) {
                  password.value = value;
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _passwordValidated,
              builder: (context, value, child) => !_passwordValidated.value
                  ? Text(
                      'Invalid Credentials',
                      textAlign: TextAlign.left,
                      style: kBody1.copyWith(color: Colors.red),
                    )
                  : const SizedBox(),
            ),
            spacer,
            spacer,
            spacer,
            spacer,
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) => isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : CustomButton(
                      text: 'Signin',
                      width: width * 0.7,
                      onTap: submit,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mask(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.6),
          ],
        ),
      ),
    );
  }

  Widget bgImage(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        RestaurantAssets.authBg,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget headerWidget() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Welcome to\n',
        style: kTitle0.copyWith(color: Colors.white),
        children: [
          TextSpan(
              text: 'Glints Restaurant',
              style: kTitle1.copyWith(color: Colors.orange)),
        ],
      ),
    );
  }

  void submit() async {
    {
      log('Submit button');
      isLoading.value = true;
      if (email.value.isNotEmpty && password.value.isNotEmpty) {
        _emailValidated.value = true;
        _passwordValidated.value = true;
        AuthBody authBody =
            AuthBody(email: email.value, password: password.value);
        bool success = await authCubit.signIn(authBody);
        if (success) {
          Future.wait([
            restaurantCubit.fetchRestaurants(1, []),
            userCubit.getUser(),
            collectionCubit.getUserCollections(),
          ]);
          isLoading.value = false;
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else {
          log('Here');
          _passwordValidated.value = false;
          _emailValidated.value = false;
        }
      } else {
        _passwordValidated.value = false;
        _emailValidated.value = false;
        isLoading.value = false;
      }
    }
  }
}
