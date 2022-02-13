import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/data/api/token_service.dart';
import 'package:client/data/models/auth_body.dart';
import 'package:client/data/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthCubit() : super(const AuthInitial());

  Future<void> isAuthenticated() async {
    emit(const AuthLoading());
    bool isAuthenticated = await TokenService().init();

    emit(AuthLoaded(isAuthenticated));
  }

  Future<bool> signIn(AuthBody authBody) async {
    emit(const AuthLoading());
    try {
      bool isAuthenticated = await _authRepository.signIn(authBody);
      emit(AuthLoaded(isAuthenticated));
      return isAuthenticated;
    } catch (err) {
      log(err.toString());
      emit(AuthError(err.toString()));
      return false;
    }
  }

  Future<void> logoutUser() async {
    emit(const AuthLoading());
    await _authRepository.logout();
    emit(const AuthLoaded(false));
  }
}
