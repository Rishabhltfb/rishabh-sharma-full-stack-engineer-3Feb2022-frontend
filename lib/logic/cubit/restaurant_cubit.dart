import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:client/data/repository/filter/filter_repository.dart';
import 'package:client/data/repository/restaurant/restaurant_repository.dart';
import 'package:client/utils/util_functions.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();
  final FilterRepository _filterRepository = FilterRepository();
  final List<Restaurant> _allRestaurant = [];

  RestaurantCubit() : super(const RestaurantInitial());

  Future<List<Restaurant>> fetchRestaurants(
      int page, List<Restaurant> recentSearchedRestaurantsList) async {
    try {
      log('fetch Restaurant Page $page');
      List<Restaurant> restaurantsList =
          await _restaurantRepository.fetchRestaurants(page);
      _allRestaurant.addAll(restaurantsList);
      log('Total restaurants : ${_allRestaurant.length.toString()}');
      emit(RestaurantLoaded(_allRestaurant, recentSearchedRestaurantsList,
          page: page));
      return restaurantsList;
    } catch (err) {
      log(err.toString());
      emit(RestaurantError(err.toString()));
      return [];
    }
  }

  Future<bool> addRestaurant(Restaurant restaurant) async {
    try {
      bool success = await _restaurantRepository.addRestaurant(restaurant);
      return success;
    } catch (err) {
      emit(RestaurantError(err.toString()));
      return false;
    }
  }

  Future<List<Restaurant>> filterByRestaurantName(String name) async {
    try {
      emit(const RestaurantLoading());
      List<Restaurant> filteredRestaurantsList =
          await _filterRepository.filterByRestaurantName(name);
      emit(RestaurantFilterApplied(filteredRestaurantsList));
      return filteredRestaurantsList;
    } catch (err) {
      log(err.toString());
      emit(RestaurantError(err.toString()));
      return [];
    }
  }

  Future<List<Restaurant>> filterByDayTime(
      String day, int startTime, int endTime) async {
    try {
      emit(const RestaurantLoading());
      List<Restaurant> filteredRestaurantsList =
          await _filterRepository.filterByDayTime(day, startTime, endTime);
      emit(RestaurantFilterApplied(filteredRestaurantsList));
      return filteredRestaurantsList;
    } catch (err) {
      log(err.toString());
      emit(RestaurantError(err.toString()));
      return [];
    }
  }

  void resetFilter(List<Restaurant> restaurantList,
      List<Restaurant> recentSearchedRestaurantsList) {
    emit(RestaurantLoaded(restaurantList, recentSearchedRestaurantsList));
  }

  void addRecentSearchedRestaurants(List<Restaurant> restaurantList,
      List<Restaurant> recentSearchedRestaurantsList) {
    emit(RestaurantLoaded(restaurantList, recentSearchedRestaurantsList));
  }
}
