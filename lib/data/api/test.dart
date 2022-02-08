// import 'dart:developer';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/dio_client.dart';
import 'package:dio/dio.dart';

class TestApi {
  static final TestApi instance = TestApi._internal();

  TestApi._internal();

  factory TestApi() {
    return instance;
  }

  final DioClient _client = DioClient();

  Future<Response> test() async {
    String url = "/test";
    // http.Response res;
    Response res;
    try {
      res = await _client.dio.get(BASE_URL + url);
    } catch (err) {
      // log(err.toString());
      throw Exception(err);
    }
    return res;
  }
}
