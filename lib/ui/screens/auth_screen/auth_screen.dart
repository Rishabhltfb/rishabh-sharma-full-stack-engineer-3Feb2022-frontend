import 'dart:developer';

import 'package:client/data/models/auth_body.dart';
import 'package:client/logic/cubit/auth_cubit.dart';
import 'package:client/ui/common_widgets/custom_button.dart';
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
  final ValueNotifier<String> email = ValueNotifier('');
  final ValueNotifier<String> password = ValueNotifier('');

  @override
  void dispose() {
    _emailValidated.dispose();
    _passwordValidated.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              bgImage(height, width),
              mask(height, width),
              body(height, width),
            ],
          ),
        ),
      ),
    );
  }

  Positioned body(double height, double width) {
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
            SizedBox(
              width: width * 0.75,
              child: createTextField(
                  'Email Address', 'Please enter your email', '',
                  onChanged: (String value) {
                email.value = value;
              }),
            ),
            spacer,
            spacer,
            SizedBox(
              width: width * 0.75,
              child: createTextField(
                'Password',
                'Please enter password',
                '',
                onChanged: (String value) {
                  password.value = value;
                },
                error: false,
              ),
            ),
            spacer,
            spacer,
            spacer,
            spacer,
            CustomButton(
              text: 'SignIn',
              width: width * 0.7,
              onTap: submit,
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

  Widget createTextField(
    title,
    hintText,
    textFieldInitialValue, {
    Color? filledColor,
    bool enabled = true,
    Function? onChanged,
    bool error = false,
  }) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    );
    Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        createTextFieldTitle(title, error: error),
        SizedBox(
          height: 50,
          child: Stack(
            children: [
              TextFormField(
                initialValue: textFieldInitialValue,
                textInputAction: TextInputAction.done,
                enabled: enabled,
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  disabledBorder: outlineInputBorder,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget createTextFieldTitle(String title,
      {bool error = false, Color color = Colors.white}) {
    if (error) {
      color = Colors.red;
    }
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10, bottom: 8, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
            ),
          ),
          error
              ? Text(
                  '* Necessary',
                  style: TextStyle(
                    color: color.withOpacity(0.5),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void submit() async {
    {
      log('Inside submit function');
      _emailValidated.value = email.value.isNotEmpty;
      _passwordValidated.value = password.value.isNotEmpty;
      if (_emailValidated.value && _passwordValidated.value) {
        AuthBody authBody =
            AuthBody(email: email.value, password: password.value);
        bool success =
            await BlocProvider.of<AuthCubit>(context).signIn(authBody);
        if (success) {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else {
          _passwordValidated.value = false;
          _emailValidated.value = false;
        }
      }
    }
  }
}
