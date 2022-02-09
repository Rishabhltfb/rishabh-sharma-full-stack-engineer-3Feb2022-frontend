import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/data/models/restaurant.dart';

class Collection {
  String id;
  String name;
  List<Restaurant> restautants;
  DateTime createdAt;
  DateTime updatedAt;
  Collection({
    required this.id,
    required this.name,
    required this.restautants,
    required this.createdAt,
    required this.updatedAt,
  });

  Collection copyWith({
    String? id,
    String? name,
    List<Restaurant>? restautants,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      restautants: restautants ?? this.restautants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restautants': restautants.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      restautants: List<Restaurant>.from(
          map['restautants']?.map((x) => Restaurant.fromMap(x))),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Collection(id: $id, name: $name, restautants: $restautants, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.id == id &&
        other.name == name &&
        listEquals(other.restautants, restautants) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        restautants.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
