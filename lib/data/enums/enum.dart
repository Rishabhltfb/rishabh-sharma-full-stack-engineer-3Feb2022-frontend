// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Weekdays {
  Mon,
  Tues,
  Wed,
  Thu,
  Fri,
  Sat,
  Sun,
}

extension WeekdaysExtension on Weekdays {
  String get name => describeEnum(this);
}
