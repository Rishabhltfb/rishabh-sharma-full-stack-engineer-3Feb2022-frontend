import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:client/data/repository/restaurant/restaurant_repository.dart';
import 'package:client/utils/util_functions.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  RestaurantCubit() : super(const RestaurantInitial());

  Future<List<Restaurant>> fetchAllRestaurants() async {
    try {
      List<Restaurant> restaurantsList =
          await _restaurantRepository.fetchAllRestaurants();
      emit(RestaurantLoaded(restaurantsList));
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
}
