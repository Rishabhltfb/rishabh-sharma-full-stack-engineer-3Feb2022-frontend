import 'dart:convert';
import 'package:client/data/api/filter/filter_api.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:dio/dio.dart';

class FilterRepository {
  static final FilterRepository instance = FilterRepository._internal();
  final FilterApi _filterApi = FilterApi();

  FilterRepository._internal();

  factory FilterRepository() {
    return instance;
  }

  Future<List<Restaurant>> filterByRestaurantName(String name) async {
    List<Restaurant> restaurantList = [];
    Response res = await _filterApi.filterByRestaurantName(name);
    dynamic data = jsonDecode(res.data['data']);
    data.forEach((ele) {
      restaurantList.add(Restaurant.fromMap(ele));
    });
    return restaurantList;
  }

  Future<List<Restaurant>> filterByDayTime(
      String day, int startTime, int endTime) async {
    List<Restaurant> restaurantList = [];
    Response res = await _filterApi.filterByDayTime(day, startTime, endTime);
    dynamic data = jsonDecode(res.data['data']);
    data.forEach((ele) {
      restaurantList.add(Restaurant.fromMap(ele));
    });
    return restaurantList;
  }
}
