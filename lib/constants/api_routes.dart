// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

// String BASE_URL = dotenv.env['BASE_URL'] ?? "";
String BASE_URL = dotenv.env['DEPLOYED_URL'] ?? "";
