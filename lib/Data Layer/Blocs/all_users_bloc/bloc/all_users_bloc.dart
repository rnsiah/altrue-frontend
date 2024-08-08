import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/all_users_repository.dart';

part 'all_users_event.dart';
part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsersRepository allUsersRepository = AllUsersRepository();

  AllUsersBloc({required this.allUsersRepository})
      : super(const AllUsersState(status: ProfileListStatus.initial)) {
    on<FetchFindUserList>(_onFetchFindUserList);
  }

  void _onFetchFindUserList(
      FetchFindUserList event, Emitter<AllUsersState> emit) async {
    emit(state.copyWith(status: ProfileListStatus.loading));
    try {
      List<ProfileRepresentation> list =
          await allUsersRepository.getAllProfiles();
      emit(
          state.copyWith(userList: list, status: ProfileListStatus.successful));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ProfileListStatus.failure));
    }
  }

  // @override
  // Stream<AllUsersState> mapEventToState(AllUsersEvent event) async* {
  //   if (event is FetchFindUserList) {
  //     yield state.copyWith(status: ProfileListStatus.loading);
  //     try {
  //       List<ProfileRepresentation> list =
  //           await allUsersRepository.getAllProfiles();
  //       yield state.copyWith(
  //           userList: list, status: ProfileListStatus.successful);
  //     } catch (e) {
  //       print(e.toString());
  //       yield state.copyWith(status: ProfileListStatus.failure);
  //     }
  //   }
  // }
}
