part of 'all_users_bloc.dart';

enum ProfileListStatus { initial, loading, successful, failure }

class AllUsersState extends Equatable {
  final List<ProfileRepresentation> userList;
  final ProfileListStatus status;

  const AllUsersState(
      {this.userList = const <ProfileRepresentation>[],
      this.status = ProfileListStatus.initial});

  AllUsersState copyWith(
      {final List<ProfileRepresentation>? userList,
      final ProfileListStatus? status}) {
    return AllUsersState(
        userList: userList ?? this.userList, status: status ?? this.status);
  }

  @override
  List<Object> get props => [userList, status];
}
