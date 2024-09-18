
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';

part 'nonprofit_event.dart';
part 'nonprofit_state.dart';

class NonprofitBloc extends Bloc<NonprofitEvent, NonprofitState> {
  final NonProfitRespository nonProfitRespository;
  NonprofitBloc({required this.nonProfitRespository})
      : super(const NonprofitState()) {
    on<FetchNonProfitList>(_fetchNonProfitList);
    on<FetchNonProfitItem>(_fetchNonProfitItem);
    on<FetchNonProfitsByCategory>(_fetchNonProfitsByCategory);
    on<FetchFeaturedNonProfits>(_fetchFeaturedNonProfits);
    fetchNonProfitsOnLogin();
  
  }

      void _fetchNonProfitList(FetchNonProfitList event, Emitter<NonprofitState> emit) async {
    try {
      List<NonProfit> nonprofitList =
          await nonProfitRespository.fetchNonProfits();
      NonprofitState newState = state.copyWith(
          nonprofitList: nonprofitList, status: NonProfitStatus.success);
      emit(newState);
    } catch (e) {
      emit(state.copyWith(status: NonProfitStatus.failure));
    }}

    void _fetchNonProfitItem(FetchNonProfitItem event, Emitter<NonprofitState> emit) async {
    try {
      await nonProfitRespository.fetchNonProfit(event.nonProfit.id);
    } catch (e) {
      emit(state.copyWith(status: NonProfitStatus.failure));
    }
    }

    fetchNonProfitsOnLogin() async {
    if (state.status == NonProfitStatus.initial) {
      try {
        List<NonProfit> all = await nonProfitRespository.fetchNonProfits();
        List<NonProfit> featured = await nonProfitRespository.fetchFeaturedNonProfits();

        if (all.isNotEmpty) {
          NonprofitState newState = state.copyWith(
            featuredNonProfits: featured,
              nonprofitList: all, status: NonProfitStatus.success);
          emit(newState);
        }
      } catch (e) {
        print(e.toString());
        NonprofitState newState =
            state.copyWith(status: NonProfitStatus.failure);
        emit(newState);
      }
    }
  }

    void _fetchNonProfitsByCategory(FetchNonProfitsByCategory event, Emitter<NonprofitState> emit) async {
    NonprofitState newState = state.copyWith(categoryChange: false);
    emit(newState);
    try {
      List<NonProfit> categoryList =
          await nonProfitRespository.fetchNonProfitByCategory(event.category);
      
      NonprofitState newState = state.copyWith(
          nonprofitList: categoryList,
          status: NonProfitStatus.success,
          categoryChange: true);
      emit(newState);
    } catch (e) {
      emit(state.copyWith(status: NonProfitStatus.failure));
    }
  }

  void _fetchFeaturedNonProfits(FetchFeaturedNonProfits event, Emitter<NonprofitState> emit)async {
    NonprofitState state = this.state;
    NonprofitState newState = state.copyWith(status: NonProfitStatus.loading);
    emit(newState);
    try{
      List<NonProfit> featuredNonProfits = await nonProfitRespository.fetchFeaturedNonProfits();
      NonprofitState theState = newState.copyWith(featuredNonProfits: featuredNonProfits);
      emit(theState);
    }
    catch(e){
      null;
    }
  }
}
  // Stream<NonprofitState> mapEventToState(
  //   NonprofitEvent event,
  // ) async* {
  //   if (event is FetchNonProfitList) {
  //     try {
  //       List<NonProfit> nonprofitList =
  //           await nonProfitRespository.fetchNonProfits();
  //       NonprofitState newState = state.copyWith(
  //           nonprofitList: nonprofitList, status: NonProfitStatus.success);
  //       yield newState;
  //     } catch (e) {
  //       yield state.copyWith(status: NonProfitStatus.failure);
  //     }
  //   }
  //   if (event is FetchNonProfitItem) {
  //     try {
  //       await nonProfitRespository.fetchNonProfit(event.nonProfit.id);
  //     } catch (e) {
  //       yield state.copyWith(status: NonProfitStatus.failure);
  //     }
  //   }
  //   if (event is FetchNonProfitsByCategory) {
  //     NonprofitState newState = state.copyWith(categoryChange: false);
  //     yield newState;
  //     try {
  //       List<NonProfit> categoryList =
  //           await nonProfitRespository.fetchNonProfitByCategory(event.category);
  //       if (categoryList.isEmpty) {
  //         List<NonProfit> allNonProfits =
  //             await nonProfitRespository.fetchFeaturedNonProfits();
  //         NonprofitState newState = state.copyWith(
  //             categoryNonProfitList: allNonProfits,
  //             nonprofitList: state.nonprofitList,
  //             status: NonProfitStatus.success);
  //         yield newState;
  //       }
  //       NonprofitState newState = state.copyWith(
  //           categoryNonProfitList: categoryList,
  //           categoryChange: true,
  //           status: NonProfitStatus.success);
  //       yield newState;
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   }
  // }

