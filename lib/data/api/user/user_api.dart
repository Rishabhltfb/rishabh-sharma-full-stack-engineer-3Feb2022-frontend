import 'package:client/constants/api_routes.dart';
import 'package:client/data/api/dio_client.dart';
import 'package:dio/dio.dart';

class UserApi {
  static final UserApi instance = UserApi._internal();

  UserApi._internal();

  factory UserApi() {
    return instance;
  }

  final DioClient _client = DioClient();

  Future<Response> getUser() async {
    String url = "/user";
    Response res;
    try {
      res = await _client.dio.get(BASE_URL + url);
    } catch (err) {
      throw Exception(err);
    }
    return res;
  }
}
