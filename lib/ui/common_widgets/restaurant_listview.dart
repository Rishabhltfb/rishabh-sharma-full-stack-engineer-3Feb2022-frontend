import 'package:client/data/models/restaurant.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_tile.dart';
import 'package:client/ui/screens/restaurant_screen/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RestaurantListView extends StatelessWidget {
  final List<Restaurant> restaurantsList;
  final ValueNotifier<List<Restaurant>>? recentSearchedRestaurantsList;
  const RestaurantListView(
      {Key? key,
      required this.restaurantsList,
      this.recentSearchedRestaurantsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thickness: 10,
      radius: const Radius.circular(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: restaurantsList.length,
        physics: const BouncingScrollPhysics(),
        primary: false,
        itemBuilder: (context, index) {
          Restaurant restaurant = restaurantsList[index];
          return RestaurantTile(
            restaurant: restaurant,
            onTap: () {
              if (recentSearchedRestaurantsList != null) {
                bool isFound = false;
                for (int i = 0;
                    i < recentSearchedRestaurantsList!.value.length;
                    i++) {
                  if (recentSearchedRestaurantsList!.value[i].id ==
                      restaurant.id) {
                    isFound = true;
                    break;
                  }
                }
                if (!isFound) {
                  recentSearchedRestaurantsList!.value =
                      List.from(recentSearchedRestaurantsList!.value)
                        ..add(restaurant);
                }
              }

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return RestaurantScreen(restaurant: restaurant);
                },
              ));
            },
          );
        },
      ),
    );
  }
}
