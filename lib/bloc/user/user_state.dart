part of 'user_cubit.dart';

class UserState extends Equatable {
  final ApiState? apiState;
  final UserModel? users;
  final ResInvalidBaseModel? error;
  final UserModel? favouriteUsers;
  final bool loadingMore;

  const UserState({
    this.apiState,
    this.users,
    this.error,
    this.favouriteUsers,
    this.loadingMore = false,
  });

  UserState copyWith({
    final ApiState? apiState,
    final UserModel? user,
    final ResInvalidBaseModel? error,
    final UserModel? favouriteUsers,
    final bool? loadingMore,
  }) {
    return UserState(
      apiState: apiState ?? this.apiState,
      users: user ?? users,
      error: error ?? this.error,
      favouriteUsers: favouriteUsers ?? this.favouriteUsers,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  List<Object?> get props => [
        apiState,
        users,
        error,
        favouriteUsers,
        loadingMore,
      ];
}
