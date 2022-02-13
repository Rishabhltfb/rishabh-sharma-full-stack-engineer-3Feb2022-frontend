import 'package:client/data/models/restaurant.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  const RestaurantCard(
      {Key? key, required this.restaurant, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = getViewportHeight(context);
    double width = getViewportWidth(context);
    SizedBox spacer = const SizedBox(height: 5);
    BorderRadius borderRadius = const BorderRadius.all(
      Radius.circular(15),
    );
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: borderRadius,
          elevation: 5.0,
          child: Container(
            width: width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.18,
                  width: width * 0.45,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(restaurant.image, fit: BoxFit.cover)),
                ),
                spacer,
                Text(
                  restaurant.restaurantName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: kBody2.copyWith(fontWeight: FontWeight.w500),
                ),
                spacer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
