import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLine extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerLine({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE5ECEF).withOpacity(0.9),
      highlightColor: const Color(0xffE5ECEF).withOpacity(0.3),
      period: const Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xffE5ECEF),
          borderRadius: BorderRadius.all(
            Radius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
