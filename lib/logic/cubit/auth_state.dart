part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState {
  final bool isAuthenticated;
  const AuthLoaded(this.isAuthenticated);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthLoaded && other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode => isAuthenticated.hashCode;
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
