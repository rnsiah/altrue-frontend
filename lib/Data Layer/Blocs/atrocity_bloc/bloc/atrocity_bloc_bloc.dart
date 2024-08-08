
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/atrocity_repositories.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'atrocity_bloc_event.dart';
part 'atrocity_bloc_state.dart';

class AtrocityBlocBloc extends Bloc<AtrocityBlocEvent, AtrocityBlocState> {
  AtrocityRepository atrocityRepository;
  UserRepository userRepository = UserRepository();

  AtrocityBlocBloc({required this.atrocityRepository})
      : super(const AtrocityBlocState()) {
    fetchAtrocitiesonStart();
    on<AtrocityListFetched>(_atrocityListFetched);
    on<AtrocityItemFteched>(_atrocityItemFetched);
    on<AtrocityListFetchedByCategory>(_atrocityListFetchedByCategory);
  }

  void _atrocityListFetched(
      AtrocityListFetched event, Emitter<AtrocityBlocState> emit) async {
    AtrocityBlocState state = this.state;
    List<Atrocity> atrocity = await atrocityRepository.getAtrocities();
    for (var i = 0; i < atrocity.length; i++) {
      emit(
          state.copyWith(atrocities: atrocity, status: AtrocityStatus.success));
    }
  }

  void _atrocityItemFetched(
      AtrocityItemFteched event, Emitter<AtrocityBlocState> emit) async {
    AtrocityBlocState state = this.state;
    await atrocityRepository.getAtrocity(event.atrocity.id!);
  }

  fetchAtrocitiesonStart() async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    if (user != null) {
      try {
        List<Atrocity> all = await atrocityRepository.getAtrocities();
        List<Atrocity> featured =
            await atrocityRepository.getFeaturedAtrocities();
        if (featured.isNotEmpty) {
          emit(AtrocityBlocState(
              featuredAtrocities: featured,
              status: AtrocityStatus.success,
              atrocities: all));
        } else {
          emit(const AtrocityBlocState(status: AtrocityStatus.failure));
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _atrocityListFetchedByCategory(AtrocityListFetchedByCategory event, Emitter<AtrocityBlocState>emit)async{
    AtrocityBlocState state = this.state;
    emit(state.copyWith(categoryChange: false));
    try {
      List<Atrocity> atrocityList = await atrocityRepository.getAtrocityListByCategory(event.category);
      if (atrocityList.isNotEmpty) {
        AtrocityBlocState newState = state.copyWith(
            atrocities: state.atrocities,
            atrocityCategoryList: atrocityList,
            status: AtrocityStatus.success,
            categoryChange: true);
        emit(newState);
      }
    } catch (e) {
      print(e.toString());
    } 
  }

  // Stream<AtrocityBlocState> mapEventToState(
  //   AtrocityBlocEvent event,
  // ) async* {
  //   if (event is AtrocityListFetched) {
  //     List<Atrocity> atrocity = await atrocityRepository.getAtrocities();

  //     for (var i = 0; i < atrocity.length; i++) {
  //       yield state.copyWith(
  //           atrocities: atrocity, status: AtrocityStatus.success);
  //     }
  //   }
  //   if (event is AtrocityItemFteched) {
  //     await atrocityRepository.getAtrocity(event.atrocity.id!);
  //   }
  //   if (event is AtrocityListFetchedByCategory) {
  //     yield state.copyWith(categoryChange: false);
  //     try {
  //       List<Atrocity> atrocityList =
  //           await atrocityRepository.getAtrocityListByCategory(event.category);
  //       if (atrocityList.isNotEmpty) {
  //         AtrocityBlocState newState = state.copyWith(
  //             atrocities: state.atrocities,
  //             atrocityCategoryList: atrocityList,
  //             status: AtrocityStatus.success,
  //             categoryChange: true);
  //         yield newState;
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //     if (event is FeaturedAtrocityListFetched) {
  //       yield state.copyWith(status: AtrocityStatus.initial);
  //       try {
  //         List<Atrocity> atrocityList =
  //             await atrocityRepository.getFeaturedAtrocities();
  //         yield state.copyWith(
  //             featuredAtrocities: atrocityList, status: AtrocityStatus.success);
  //       } catch (e) {
  //         print(e.toString());
  //       }
  //     }
  //   }
  // }
}
