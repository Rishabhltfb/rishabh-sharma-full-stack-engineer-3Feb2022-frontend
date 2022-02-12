import 'package:bloc/bloc.dart';
import 'package:client/data/models/user.dart';
import 'package:client/data/repository/user/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();
  UserCubit() : super(const UserInitial());

  Future<User> getUser() async {
    emit(const UserLoading());
    try {
      User user = await _userRepository.getUser();
      emit(UserLoaded(user));
      return user;
    } catch (err) {
      emit(UserError(err.toString()));
      return User.empty();
    }
  }
}
