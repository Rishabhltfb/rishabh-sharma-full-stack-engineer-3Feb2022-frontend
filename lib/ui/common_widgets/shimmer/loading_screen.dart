import 'package:client/ui/common_widgets/shimmer/shimmer_line.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = getViewportWidth(context);
    double height = getViewportHeight(context);
    Widget spacer = const SizedBox(height: 16);
    return SizedBox(
      // color: Colors.white,
      width: width,
      // height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLine(width: width * 0.9, height: 26),
            spacer,
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: shimmerTile(height, width),
              ),
          ],
        ),
      ),
    );
  }

  Widget shimmerTile(double height, double width) {
    Widget spacer = const SizedBox(height: 6);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0xffE5ECEF).withOpacity(0.9),
            highlightColor: const Color(0xffE5ECEF).withOpacity(0.3),
            period: const Duration(seconds: 2),
            child: Container(
              height: height * 0.15,
              width: width * 0.25,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShimmerLine(width: width * 0.25, height: 16),
              spacer,
              ShimmerLine(width: width * 0.45, height: 16),
              spacer,
              ShimmerLine(width: width * 0.45, height: 16),
            ],
          )
        ],
      ),
    );
  }
}
