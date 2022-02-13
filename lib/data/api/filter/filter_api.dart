import 'dart:developer';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/dio_client.dart';
import 'package:dio/dio.dart';

class FilterApi {
  static final FilterApi instance = FilterApi._internal();

  FilterApi._internal();

  factory FilterApi() {
    return instance;
  }

  final DioClient _client = DioClient();

  Future<Response> filterByRestaurantName(String name) async {
    String url = "/filter/name";
    var queryParameters = {'name': name};
    Response res;
    try {
      res = await _client.dio
          .get(BASE_URL + url, queryParameters: queryParameters);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> filterByDayTime(
      String day, int startTime, int endTime) async {
    String url = "/filter/day";
    var queryParameters = {
      'day': day,
      'openingTime': startTime,
      'closingTime': endTime
    };
    Response res;
    try {
      res = await _client.dio
          .get(BASE_URL + url, queryParameters: queryParameters);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }
}
