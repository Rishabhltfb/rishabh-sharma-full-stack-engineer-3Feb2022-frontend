import 'dart:io';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/token_service.dart';
import 'package:client/data/models/auth_body.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static final AuthApi instance = AuthApi._internal();

  AuthApi._internal();

  factory AuthApi() {
    return instance;
  }

  final _client = http.Client();

  Future<http.Response> signIn(AuthBody authBody) async {
    String url = BASE_URL + "/auth/signin";
    Uri uri = Uri.parse(url);
    http.Response res =
        await _client.post(uri, body: authBody.toJson(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return res;
  }

  Future<http.Response> logout() {
    // TODO: Add logout API in backend, then add here.
    String url = BASE_URL + "/auth/refresh-token/revoke";
    Uri uri = Uri.parse(url);
    return _client.put(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-access-token': TokenService().refreshToken,
      HttpHeaders.authorizationHeader: "Bearer " + TokenService().jwtToken
    });
  }

  Future<http.Response> refreshJwtToken() {
    String url = BASE_URL + "/auth/refresh-token/refresh";
    Uri uri = Uri.parse(url);
    return _client.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-access-token': TokenService().refreshToken,
      'access-token': TokenService().jwtToken
    });
  }
}
