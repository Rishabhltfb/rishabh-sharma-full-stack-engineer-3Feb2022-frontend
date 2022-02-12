import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/data/models/collection.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:client/data/repository/collection/collection_repository.dart';
import 'package:client/utils/util_functions.dart';
import 'package:meta/meta.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository _collectionRepository = CollectionRepository();

  CollectionCubit() : super(const CollectionInitial());

  Future<bool> updateCollection(
      Collection updatedCollection, String userId) async {
    try {
      bool success = await _collectionRepository.updateCollection(
          updatedCollection, userId);
      return success;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<bool> addRestaurantToCollection(
      Restaurant restaurant, String collectionId) async {
    try {
      bool success = await _collectionRepository.addRestaurantToCollection(
          restaurant, collectionId);
      // _collectionRepository.getUserCollections();
      return success;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<List<Collection>> getUserCollections() async {
    List<Collection> collectionList = [];
    try {
      emit(const CollectionLoading());
      collectionList = await _collectionRepository.getUserCollections();
      emit(CollectionLoaded(collectionList));
      return collectionList;
    } catch (err) {
      emit(CollectionError(err.toString()));
      return [];
    }
  }

  Future<bool> createUserCollection(
      Collection newCollection, String userId) async {
    try {
      _collectionRepository.createUserCollection(newCollection, userId);
      return true;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
