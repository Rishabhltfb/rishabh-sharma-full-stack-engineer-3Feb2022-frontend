import 'package:client/data/models/restaurant.dart';
import 'package:client/ui/screens/restaurant_screen/restaurant_screen.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vpH = getViewportHeight(context);
    var vpW = getViewportWidth(context);
    TextStyle _titlestyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: vpH * 0.025);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return RestaurantScreen(restaurant: restaurant);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 8.0,
          child: Container(
            height: vpH * 0.15,
            width: vpW * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Hero(
                    tag: restaurant.id ?? restaurant.restaurantName,
                    child: Container(
                      height: vpH * 0.15,
                      width: vpW * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: Image.asset(RestaurantAssets.authBg,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.restaurantName,
                          overflow: TextOverflow.ellipsis,
                          style: _titlestyle,
                        ),
                        Text(
                          restaurant.time,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 8.0),
                        //   child: Text(
                        //     "AMURoboclub",
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}