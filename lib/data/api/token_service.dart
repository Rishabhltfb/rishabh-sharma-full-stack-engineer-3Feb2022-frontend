import 'dart:developer';

import 'package:client/constants/api_constants.dart';
import 'package:client/data/repository/local_db/secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  final SecureStorageRepository _secureStorageRepository =
      SecureStorageRepository();

  TokenService._internal();

  factory TokenService() {
    return _instance;
  }

  String jwtToken = "";
  String refreshToken = "";

  Future<bool> init() async {
    jwtToken =
        await _secureStorageRepository.secureRead(JWT_TOKEN_SECURE_STORAGE) ??
            "";
    refreshToken = await _secureStorageRepository
            .secureRead(REFRESH_TOKEN_SECURE_STORAGE) ??
        "";
    if (refreshToken.isNotEmpty && jwtToken.isNotEmpty) {
      if (!isTokenExpired(refreshToken)) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  bool isTokenExpired(String _token) {
    if (_token.isEmpty) return true;
    try {
      DateTime? expiryDate = Jwt.getExpiryDate(_token);
      if (expiryDate != null) {
        bool isExpired = expiryDate
                .compareTo(DateTime.now().add(const Duration(minutes: 2))) <=
            0;
        return isExpired;
      } else {
        return true;
      }
    } on Exception catch (err) {
      log(err.toString());
      return true;
    }
  }
}
