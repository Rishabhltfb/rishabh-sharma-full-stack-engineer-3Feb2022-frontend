import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final String text;
  const Chips({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(text, style: kCaption2),
      ),
    );
  }
}
