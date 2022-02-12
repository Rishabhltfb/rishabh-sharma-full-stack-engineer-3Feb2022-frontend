part of 'user_cubit.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLoaded && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
