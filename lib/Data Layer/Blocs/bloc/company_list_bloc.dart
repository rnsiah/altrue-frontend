import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'company_list_event.dart';
part 'company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final CompanyRepository companyRepository = CompanyRepository();
  final UserRepository userRepository = UserRepository();
  CompanyListBloc() : super(const CompanyListState()){
    on<FetchCompanyList>(_onFetchCompanyList);
    on<FetchCompanyListByCategory>(_fetchCompanyListByCategory);
    _fetchCompanyOnLogin();
  }

  void _onFetchCompanyList(FetchCompanyList event, Emitter<CompanyListState> emit) async {
    emit(state.copyWith(status: CompanyListStatus.loading));
    try {
      List<ForProfitCompany> company =
          await companyRepository.getCompanyList();
          print(company.toString());
      emit(state.copyWith(
          companies: company, status: CompanyListStatus.success));
    } catch (e) {
      print(e.toString());
      emit(CompanyListFailed());
    }
  }

  void _fetchCompanyOnLogin() async{
    if (state.status == CompanyListStatus.inital){
      try{
        User? user = await userRepository.userDao.getCurrentUser(0);
        List<ForProfitCompany> all = await companyRepository.getCompanyList();
        if(all.isNotEmpty){
          CompanyListState newState = state.copyWith(companies: all, status: CompanyListStatus.success);
          emit(newState);
        }
      }catch(e){
        CompanyListState newState = state.copyWith(status: CompanyListStatus.failed);
        emit(newState);
      }
    }
  }

  void _fetchCompanyListByCategory(FetchCompanyListByCategory event, Emitter<CompanyListState>emit)async{
    CompanyListState state= this.state;
    emit(state.copyWith(categoryChange: false));
    try {
      List<ForProfitCompany> company =
          await companyRepository.getCompanyListByCategory(
               category: event.category);
      emit(state.copyWith(
          companies: company, status: CompanyListStatus.success));
    } catch (e) {
      print(e.toString());
      emit(CompanyListFailed());
    }
  }

  

  // @override
  // Stream<CompanyListState> mapEventToState(CompanyListEvent event) async* {
  //   if (event is FetchCompanyList) {
  //     List<ForProfitCompany> company =
  //         await companyRepository.getCompanyList(user: event.user);

  //     yield state.copyWith(
  //         companies: company, status: CompanyListStatus.success);
  //   }
  //   if (event is CompanyListFetchedByCategory) {
  //     yield (const CompanyListState(status: CompanyListStatus.loading));
  //     try {
  //       List<ForProfitCompany> company =
  //           await companyRepository.getCompanyListByCategory(
  //               user: event.user, category: event.category);
  //       if (company.length > 1) {
  //         yield CompanyListState(
  //             companies: company, status: CompanyListStatus.success);
  //       }
  //     } catch (e) {
  //       yield CompanyListFailed();
  //     }
  //   }
  // }
}
