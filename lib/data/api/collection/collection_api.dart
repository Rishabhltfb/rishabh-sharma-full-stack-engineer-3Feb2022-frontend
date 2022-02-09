import 'dart:developer';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/dio_client.dart';
import 'package:client/data/models/collection.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:dio/dio.dart';

class CollectionApi {
  static final CollectionApi instance = CollectionApi._internal();

  CollectionApi._internal();

  factory CollectionApi() {
    return instance;
  }

  final DioClient _client = DioClient();

  Future<Response> getUserCollections() async {
    String url = "/collection";
    Response res;
    try {
      res = await _client.dio.get(BASE_URL + url);
      log(res.toString(), name: 'Filter res:');
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> createUserCollection(Collection collection) async {
    String url = "/collection";
    Response res;
    try {
      res = await _client.dio.post(BASE_URL + url, data: collection.toJson());
      log(res.toString(), name: 'Filter day res:');
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> addRestaurantToCollection(Restaurant restaurant) async {
    String url = "/collection";
    Response res;
    try {
      res = await _client.dio.put(BASE_URL + url, data: restaurant.toJson());
      log(res.toString(), name: 'Filter day res:');
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }
}
