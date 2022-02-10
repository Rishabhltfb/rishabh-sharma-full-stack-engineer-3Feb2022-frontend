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
  final List<Restaurant> restaurantsList;
  const RestaurantLoaded(this.restaurantsList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantLoaded &&
        UtilFunctions.listEquals(other.restaurantsList, restaurantsList);
  }

  @override
  int get hashCode => restaurantsList.hashCode;
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
