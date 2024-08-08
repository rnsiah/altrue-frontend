part of 'all_users_bloc.dart';

abstract class AllUsersEvent extends Equatable {
  const AllUsersEvent();

  @override
  List<Object> get props => [];
}

class FetchFindUserList extends AllUsersEvent {
  FetchFindUserList();
}
