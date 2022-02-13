import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageWidget extends StatelessWidget {
  final double height;
  final String svgPicture;
  final String message;
  const MessageWidget(
      {Key? key,
      required this.height,
      required this.svgPicture,
      this.message = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(svgPicture, height: height),
        Text(message,
            textAlign: TextAlign.center,
            style: kTitle1.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
