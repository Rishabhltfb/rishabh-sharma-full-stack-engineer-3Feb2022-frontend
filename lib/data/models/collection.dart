import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/data/models/restaurant.dart';

class Collection {
  String id;
  String name;
  List<Restaurant> restautants;
  Collection({
    required this.id,
    required this.name,
    required this.restautants,
  });

  Collection copyWith({
    String? id,
    String? name,
    List<Restaurant>? restautants,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      restautants: restautants ?? this.restautants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restautants': restautants.map((x) => x.toMap()).toList(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      restautants: List<Restaurant>.from(
          map['restautants']?.map((x) => Restaurant.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  String toString() =>
      'Collection(id: $id, name: $name, restautants: $restautants)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.id == id &&
        other.name == name &&
        listEquals(other.restautants, restautants);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ restautants.hashCode;
}
