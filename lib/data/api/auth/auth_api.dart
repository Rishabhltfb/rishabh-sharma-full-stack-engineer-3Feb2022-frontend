import 'dart:io';
import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/token_service.dart';
import 'package:http/http.dart';

class AuthApi {
  static final AuthApi instance = AuthApi._internal();

  AuthApi._internal();

  factory AuthApi() {
    return instance;
  }

  final Client _client = Client();

  Future<Response> logout() {
    // TODO: Add logout API in backend, then add here.
    Uri url = Uri.parse(BASE_URL + "/auth/refresh-token/revoke");
    return _client.put(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-access-token': TokenService().refreshToken,
      HttpHeaders.authorizationHeader: "Bearer " + TokenService().jwtToken
    });
  }

  Future<Response> refreshJwtToken() {
    Uri url = Uri.parse(BASE_URL + "/auth/refresh-token/refresh");
    return _client.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-access-token': TokenService().refreshToken,
      'access-token': TokenService().jwtToken
    });
  }
}
