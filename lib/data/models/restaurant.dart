import 'dart:convert';

import 'package:collection/collection.dart';

class Restaurant {
  String? id;
  String restaurantName = '';
  Map<String, dynamic>? schedule;
  String time = '';
  DateTime? createdAt;
  DateTime? updatedAt;
  Restaurant({
    this.id,
    required this.restaurantName,
    this.schedule,
    required this.time,
    this.createdAt,
    this.updatedAt,
  });

  Restaurant copyWith({
    String? id,
    String? restaurantName,
    Map<String, dynamic>? schedule,
    String? time,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Restaurant(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      schedule: schedule ?? this.schedule,
      time: time ?? this.time,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'schedule': schedule,
      'time': time,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['_id'],
      restaurantName: map['restaurantName'] ?? '',
      schedule: Map<String, dynamic>.from(map['schedule']),
      time: map['time'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Restaurant(id: $id, restaurantName: $restaurantName, schedule: $schedule, time: $time, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is Restaurant &&
        other.id == id &&
        other.restaurantName == restaurantName &&
        mapEquals(other.schedule, schedule) &&
        other.time == time &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        restaurantName.hashCode ^
        schedule.hashCode ^
        time.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
