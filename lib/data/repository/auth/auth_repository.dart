import 'dart:convert';
import 'dart:developer';

import 'package:client/constants/api_constants.dart';
import 'package:client/data/api/auth/auth_api.dart';
import 'package:client/data/api/token_service.dart';
import 'package:client/data/models/auth_body.dart';
import 'package:client/data/models/user.dart';
import 'package:client/data/repository/local_db/secure_storage.dart';
import 'package:client/ui/app.dart';
import 'package:client/ui/screens/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  final AuthApi _authApi = AuthApi();
  final SecureStorageRepository _secureStorageRepository =
      SecureStorageRepository();

  AuthRepository._internal();

  factory AuthRepository() {
    return instance;
  }

  Future<bool> signIn(AuthBody authBody) async {
    try {
      http.Response response = await _authApi.signIn(authBody);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);

        String jwtToken = resBody['data']['jwtToken'];
        await _secureStorageRepository.secureWrite(
            JWT_TOKEN_SECURE_STORAGE, jwtToken);
        await _secureStorageRepository.secureWrite(REFRESH_TOKEN_SECURE_STORAGE,
            response.headers["x-access-token"] ?? "");
        TokenService().jwtToken = jwtToken;
        TokenService().refreshToken = response.headers["x-access-token"] ?? "";
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on Exception catch (ex) {
      log(ex.toString());
    }
    return Future.value(false);
  }

  Future<void> logout() async {
    _authApi.logout();
    await _secureStorageRepository.secureDelete(JWT_TOKEN_SECURE_STORAGE);
    await _secureStorageRepository.secureDelete(REFRESH_TOKEN_SECURE_STORAGE);
    TokenService().jwtToken = "";
    TokenService().refreshToken = "";
    await navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (_) => false);
  }

  Future<bool> refreshJwtToken() async {
    http.Response response = await _authApi.refreshJwtToken();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String jwtToken = data['data'];
      String refreshToken = response.headers["x-access-token"] ?? "";

      await _secureStorageRepository.secureWrite(
          JWT_TOKEN_SECURE_STORAGE, jwtToken);
      await _secureStorageRepository.secureWrite(
          REFRESH_TOKEN_SECURE_STORAGE, refreshToken);
      TokenService().jwtToken = jwtToken;
      TokenService().refreshToken = refreshToken;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
