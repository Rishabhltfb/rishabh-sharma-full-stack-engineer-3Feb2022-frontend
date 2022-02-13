import 'dart:developer';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/dio_client.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:dio/dio.dart';

class RestaurantApi {
  static final RestaurantApi instance = RestaurantApi._internal();

  RestaurantApi._internal();

  factory RestaurantApi() {
    return instance;
  }

  final DioClient _client = DioClient();

  Future<Response> fetchAllRestaurants() async {
    String url = "/restaurant/all";
    Response res;
    try {
      res = await _client.dio.get(BASE_URL + url);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> addRestaurant(Restaurant restaurant) async {
    String url = "/restaurant";

    Response res;
    try {
      res = await _client.dio.post(BASE_URL + url, data: restaurant.toJson());
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }
}
