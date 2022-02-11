import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/utils/color_pallet.dart';

final ThemeData theme = ThemeData(
  appBarTheme:
      const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
  primaryColor: Colors.orange,
  splashColor: Colors.white,
  disabledColor: Colors.grey,
  cardColor: Colors.white,
  errorColor: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: color3, unselectedItemColor: Colors.grey),
  textButtonTheme: TextButtonThemeData(style: getButtonStyle()),
  elevatedButtonTheme: ElevatedButtonThemeData(style: getButtonStyle()),
  buttonTheme: const ButtonThemeData(
    buttonColor: color3,
    disabledColor: Colors.grey,
    splashColor: Colors.white,
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(Colors.grey),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.grey),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: color3, primary: color3, background: Colors.white),
);

getButtonStyle() {
  return ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
          // fontFamily: ubuntu,
          fontWeight: FontWeight.normal,
          color: Colors.white),
    ),
    elevation: MaterialStateProperty.all(6),
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.white.withOpacity(0.2);
      } else {
        return null;
      }
    }),
    backgroundColor:
        MaterialStateProperty.all(color3), // Use the component's default.
  );
}
