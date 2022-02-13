import 'dart:convert';
import 'package:client/data/api/user/user_api.dart';
import 'package:client/data/models/user.dart';
import 'package:dio/dio.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();
  final UserApi _userApi = UserApi();

  UserRepository._internal();

  factory UserRepository() {
    return instance;
  }

  Future<User> getUser() async {
    Response res = await _userApi.getUser();
    if (res.statusCode == 200 || res.statusCode == 201) {
      dynamic data = res.data['data'];
      return User.fromMap(data);
    } else {
      return User.empty();
    }
  }
}
