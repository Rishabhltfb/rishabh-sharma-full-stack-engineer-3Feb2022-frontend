import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/data/models/restaurant.dart';

class Collection {
  String id;
  String name;
  List<Restaurant> restaurants;
  Collection({
    required this.id,
    required this.name,
    required this.restaurants,
  });

  Collection copyWith({
    String? id,
    String? name,
    List<Restaurant>? restaurants,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      restaurants: restaurants ?? this.restaurants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restaurants': restaurants.map((x) => x.toMap()).toList(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      restaurants: List<Restaurant>.from(
          map['restaurants']?.map((x) => Restaurant.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  String toString() =>
      'Collection(id: $id, name: $name, restaurants: $restaurants)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.id == id &&
        other.name == name &&
        listEquals(other.restaurants, restaurants);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ restaurants.hashCode;
}
