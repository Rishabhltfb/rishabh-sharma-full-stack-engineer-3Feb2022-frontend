part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

class RestaurantLoaded extends RestaurantState {
  final int? page;
  final List<Restaurant> restaurantsList;
  final List<Restaurant> recentSearchedRestaurantsList;
  const RestaurantLoaded(
      this.restaurantsList, this.recentSearchedRestaurantsList,
      {this.page});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantLoaded &&
        UtilFunctions.listEquals(other.restaurantsList, restaurantsList) &&
        UtilFunctions.listEquals(other.recentSearchedRestaurantsList,
            recentSearchedRestaurantsList) &&
        (other.page == page);
  }

  @override
  int get hashCode => restaurantsList.hashCode;
}

class RestaurantFilterApplied extends RestaurantState {
  final List<Restaurant> filteredRestaurantsList;
  const RestaurantFilterApplied(this.filteredRestaurantsList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantLoaded &&
        UtilFunctions.listEquals(
            other.restaurantsList, filteredRestaurantsList);
  }

  @override
  int get hashCode => filteredRestaurantsList.hashCode;
}

class RestaurantError extends RestaurantState {
  final String message;
  const RestaurantError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
