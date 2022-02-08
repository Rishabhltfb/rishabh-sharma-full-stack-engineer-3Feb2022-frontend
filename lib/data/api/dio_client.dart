import 'dart:developer';
import 'dart:io';

import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/token_service.dart';
import 'package:client/data/repository/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  late final Dio dio;
  final AuthRepository _authRepository = AuthRepository();

  static final DioClient _instance = DioClient._internal();

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: Duration.millisecondsPerMinute,
        receiveTimeout: Duration.millisecondsPerMinute,
        contentType: "application/json",
      ),
    );

    if (dotenv.env["env"] != null && dotenv.env["env"] == "dev") {
      dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true));
    }
    dio.interceptors.add(_getRefreshTokenAuthInterceptor());
  }

  @override
  factory DioClient() {
    return _instance;
  }

  _getRefreshTokenAuthInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer " + TokenService().jwtToken;
      bool isJwtTokenExpired =
          TokenService().isTokenExpired(TokenService().jwtToken);
      if (isJwtTokenExpired) {
        dio.lock();
        bool isRefreshTokenExpired =
            TokenService().isTokenExpired(TokenService().refreshToken);
        if (isRefreshTokenExpired) {
          dio.clear();
          dio.unlock();
          await _authRepository.logout();
          return handler.reject(DioError(requestOptions: options));
        } else {
          bool _refreshed = await _authRepository.refreshJwtToken();
          if (_refreshed) {
            options.headers[HttpHeaders.authorizationHeader] =
                "Bearer " + TokenService().jwtToken;
            dio.unlock();
            return handler.next(options);
          } else {
            await _authRepository.logout();
            dio.clear();
            dio.unlock();
            return handler.reject(DioError(requestOptions: options));
          }
        }
      } else {
        return handler.next(options);
      }
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      log(e.toString());
      return handler.next(e);
    });
  }
}
