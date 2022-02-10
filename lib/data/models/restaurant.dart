import 'dart:convert';

import 'package:flutter/foundation.dart';

class Restaurant {
  String? id;
  String restaurantName = '';
  Map<String, dynamic>? schedule;
  String time = '';
  Restaurant({
    this.id,
    required this.restaurantName,
    this.schedule,
    required this.time,
  });

  Restaurant copyWith({
    String? id,
    String? restaurantName,
    Map<String, dynamic>? schedule,
    String? time,
  }) {
    return Restaurant(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      schedule: schedule ?? this.schedule,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'schedule': schedule,
      'time': time,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['_id'],
      restaurantName: map['restaurantName'] ?? '',
      schedule: Map<String, dynamic>.from(map['schedule']),
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Restaurant(id: $id, restaurantName: $restaurantName, schedule: $schedule, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.id == id &&
        other.restaurantName == restaurantName &&
        mapEquals(other.schedule, schedule) &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        restaurantName.hashCode ^
        schedule.hashCode ^
        time.hashCode;
  }
}
