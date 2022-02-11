import 'dart:convert';
import 'package:client/data/api/collection/collection_api.dart';
import 'package:client/data/models/collection.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:dio/dio.dart';

class CollectionRepository {
  static final CollectionRepository instance = CollectionRepository._internal();
  final CollectionApi _collectionApi = CollectionApi();

  CollectionRepository._internal();

  factory CollectionRepository() {
    return instance;
  }
  Future<List<Collection>> getUserCollections() async {
    List<Collection> collectionList = [];
    Response res = await _collectionApi.getUserCollections();
    dynamic data = res.data['data'];
    data.forEach((ele) {
      collectionList.add(Collection.fromMap(ele));
    });
    return collectionList;
  }

  Future<Collection> createUserCollection(Collection collection) async {
    Response res = await _collectionApi.createUserCollection(collection);
    dynamic data = res.data['data'];
    return Collection.fromMap(data);
  }

  Future<bool> addRestaurantToCollection(Restaurant restaurant) async {
    Response res = await _collectionApi.addRestaurantToCollection(restaurant);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
