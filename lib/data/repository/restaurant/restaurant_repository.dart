import 'package:client/data/api/restaurant/restaurant_api.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:dio/dio.dart';

class RestaurantRepository {
  static final RestaurantRepository instance = RestaurantRepository._internal();
  final RestaurantApi _restaurantApi = RestaurantApi();

  RestaurantRepository._internal();

  factory RestaurantRepository() {
    return instance;
  }
  Future<List<Restaurant>> fetchRestaurants(int page) async {
    List<Restaurant> restaurantList = [];
    Response res = await _restaurantApi.fetchRestaurants(page);
    if (res.statusCode == 200 || res.statusCode == 201) {
      dynamic data = res.data['data'];
      data.forEach((ele) {
        restaurantList.add(Restaurant.fromMap(ele));
      });
    }
    return restaurantList;
  }

  Future<bool> addRestaurant(Restaurant restaurant) async {
    Response res = await _restaurantApi.addRestaurant(restaurant);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
