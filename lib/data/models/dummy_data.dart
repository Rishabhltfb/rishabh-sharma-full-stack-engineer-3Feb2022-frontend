import 'package:client/data/enums/enum.dart';
import 'package:client/utils/assets.dart';
import 'package:flutter/material.dart';

class DummyData {
  List<Map<String, String>> cussineList = [
    {"url": RestaurantAssets.cuisine1, 'name': 'american'},
    {"url": RestaurantAssets.cuisine2, 'name': 'indian'},
    {"url": RestaurantAssets.cuisine3, 'name': 'chinese'},
    {"url": RestaurantAssets.cuisine4, 'name': 'italian'},
    {"url": RestaurantAssets.cuisine5, 'name': 'mexican'},
    {"url": RestaurantAssets.cuisine6, 'name': 'japanese'},
    {"url": RestaurantAssets.cuisine1, 'name': 'american'},
  ];
  List<String> restaurantImageList = [
    RestaurantAssets.restaurant1,
    RestaurantAssets.restaurant2,
    RestaurantAssets.restaurant3,
    RestaurantAssets.restaurant4,
    RestaurantAssets.restaurant5,
    RestaurantAssets.restaurant6,
    RestaurantAssets.restaurant7,
    RestaurantAssets.restaurant8,
    RestaurantAssets.restaurant9,
  ];
  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.blue,
  ];
  List<String> weekdays = [
    Weekdays.Mon.name,
    Weekdays.Tues.name,
    Weekdays.Wed.name,
    Weekdays.Thu.name,
    Weekdays.Fri.name,
    Weekdays.Sat.name,
    Weekdays.Sun.name,
  ];
}
