import 'package:client/ui/common_widgets/shimmer/shimmer_line.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = getViewportWidth(context);
    double height = getViewportHeight(context);
    Widget spacer = const SizedBox(height: 16);
    Widget spacer2 = const SizedBox(height: 12);
    return Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Column(
        children: [
          SizedBox(height: height * 0.1),
          Container(
            height: height * 0.25,
            width: width * 0.85,
            decoration: const BoxDecoration(
              color: Color(0xffF6F8F9),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          spacer,
          spacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLine(width: width * 0.85, height: 18),
              spacer2,
              ShimmerLine(width: width * 0.3, height: 18),
              spacer,
              spacer,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.75, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.4, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.75, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.4, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.75, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.85, height: 14),
              spacer2,
              ShimmerLine(width: width * 0.4, height: 14),
              spacer2,
            ],
          ),
        ],
      ),
    );
  }
}
