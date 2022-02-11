import 'dart:convert';

import 'package:client/data/models/dummy_data.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/util_functions.dart';
import 'package:flutter/foundation.dart';

class Restaurant {
  String? id;
  String restaurantName = '';
  Map<String, dynamic>? schedule;
  String time = '';
  String image;
  Restaurant({
    this.id,
    required this.restaurantName,
    this.schedule,
    required this.time,
    required this.image,
  });

  Restaurant copyWith({
    String? id,
    String? restaurantName,
    Map<String, dynamic>? schedule,
    String? time,
    String? image,
  }) {
    return Restaurant(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      schedule: schedule ?? this.schedule,
      time: time ?? this.time,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'schedule': schedule,
      'time': time,
      'image': image,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['_id'],
      restaurantName: map['restaurantName'] ?? '',
      schedule: Map<String, dynamic>.from(map['schedule']),
      time: map['time'] ?? '',
      image: DummyData().restaurantImageList[UtilFunctions.getRandomNumber(
          0, DummyData().restaurantImageList.length - 1)],
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Restaurant(id: $id, restaurantName: $restaurantName, schedule: $schedule, time: $time, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.id == id &&
        other.restaurantName == restaurantName &&
        mapEquals(other.schedule, schedule) &&
        other.time == time &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        restaurantName.hashCode ^
        schedule.hashCode ^
        time.hashCode ^
        image.hashCode;
  }
}
