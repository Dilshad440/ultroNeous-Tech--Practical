import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultroneous_practical/model/mapper_response/user_model.dart';
import 'package:ultroneous_practical/model/res_invalid_model.dart';
import 'package:ultroneous_practical/model/response/user_response.dart';
import 'package:ultroneous_practical/repository/user_repository.dart';
import 'package:ultroneous_practical/utils/app_utils/message_utils.dart';
import 'package:ultroneous_practical/utils/constant/global_constant.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());
  final _userRepository = UserRepository();

  int page = 1;

  void fetchUser() {
    emit(state.copyWith(apiState: ApiState.loading));
    _userRepository.fetchUsers(page: page).then(
      (response) {
        emit(state.copyWith(
          apiState: ApiState.loaded,
          user: response,
        ));
      },
      onError: (err) {
        if (err is ResInvalidBaseModel) {
          emit(
            state.copyWith(
              apiState: ApiState.error,
            ),
          );
        }
      },
    );
  }

  void fetchMoreUsers() {
    page + 1;
    emit(state.copyWith(loadingMore: true));
    _userRepository.fetchUsers(page: page).then(
      (value) {
        final List<User> fetchedUsers = value.user ?? [];
        List<User> updatedUserList = List<User>.from(state.users?.user ?? [])..addAll(fetchedUsers);
        final UserModel userModel = UserModel(user: updatedUserList);
        emit(state.copyWith(user: userModel, loadingMore: false));
      },
      onError: (err) {
        if (err is ResInvalidBaseModel) {
          emit(
            state.copyWith(
              apiState: ApiState.error,
            ),
          );
        }
      },
    );
  }

  void addUserToFavourite(User user) {
    final UserModel? favouriteUser = state.favouriteUsers;
    if (favouriteUser?.user?.isEmpty ?? false || favouriteUser?.user == null) {
      final updatedUserList = [user];
      final updatedUserModel = UserModel(user: updatedUserList);
      emit(state.copyWith(favouriteUsers: updatedUserModel));
    } else {
      final isUserAlreadyExist = favouriteUser?.user?.any((element) => element == user) ?? false;
      if (isUserAlreadyExist) return;
      final updatedUserList = [...favouriteUser!.user!, user];
      final updatedUserModel = UserModel(user: updatedUserList);
      emit(state.copyWith(favouriteUsers: updatedUserModel));
    }
    MessageUtils.showToast(message: "User added to favourite");
  }

  void removeFromFavorite(User user) {
    final UserModel? favoriteUser = state.favouriteUsers;
    if (favoriteUser == null || favoriteUser.user == null) return;

    final updatedUserList = favoriteUser.user?.where((element) => element != user).toList();
    final updatedUserModel = UserModel(user: updatedUserList);
    emit(state.copyWith(favouriteUsers: updatedUserModel));
    MessageUtils.showToast(message: "User removed from favourite");
  }
}
