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
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> createUserCollection(
      Collection collection, String userId) async {
    String url = "/collection";
    dynamic data = {
      "name": collection.name,
      "user": userId,
      "restaurants": collection.restaurants
    };
    Response res;
    try {
      res = await _client.dio.post(BASE_URL + url, data: data);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> updateCollection(
      Collection updatedCollection, String userId) async {
    String url = "/collection";
    dynamic data = {
      "user": userId,
      "_id": updatedCollection.id,
      "name": updatedCollection.name,
      "restaurants": updatedCollection.restaurants
    };
    Response res;
    try {
      res = await _client.dio.put(BASE_URL + url, data: data);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }

  Future<Response> addRestaurantToCollection(
      Restaurant restaurant, String collectionId) async {
    String url = "/collection/addRestaurant";
    dynamic data = {"restaurant": restaurant.id, "id": collectionId};
    Response res;
    try {
      res = await _client.dio.put(BASE_URL + url, data: data);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }
}
