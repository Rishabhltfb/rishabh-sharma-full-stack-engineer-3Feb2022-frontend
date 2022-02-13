import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final String textFieldInitialValue;

  final Color? filledColor;
  final bool enabled;
  final Function(String) onChanged;
  final bool error;
  const AuthTextField(
      {Key? key,
      required this.title,
      required this.hintText,
      this.textFieldInitialValue = '',
      this.filledColor,
      this.enabled = true,
      required this.onChanged,
      this.error = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    );

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
                onChanged: onChanged,
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
}
