part of 'company_list_bloc.dart';

abstract class CompanyListEvent extends Equatable {
  const CompanyListEvent();

  @override
  List<Object> get props => [];
}

class FetchCompanyListByCategory extends CompanyListEvent {
  final Category category;

  const FetchCompanyListByCategory(
      {required this.category,});

  @override
  List<Object> get props => [category,];
}

class FeaturedCompanyListFetched extends CompanyListEvent {}

class FetchCompanyList extends CompanyListEvent {
  final User user;
  const FetchCompanyList({required this.user});

  @override
  List<Object> get props => [];
}

// class FetchCompanyListByCategory extends CompanyListEvent {
//   final Category category;

//   const FetchCompanyListByCategory({required this.category});
// }
