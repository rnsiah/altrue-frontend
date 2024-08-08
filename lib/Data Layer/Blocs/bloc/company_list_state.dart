part of 'company_list_bloc.dart';

enum CompanyListStatus { inital, success, loading, failed }

class CompanyListState extends Equatable {
  final List<ForProfitCompany> companies;
  final CompanyListStatus status;
  final List<ForProfitCompany> categoryCompanyList;
  final bool categoryChange;
  final List<ForProfitCompany> featuredCompanies;

  const CompanyListState(
      {this.companies = const [],
      this.status = CompanyListStatus.inital,
      this.categoryChange = false,
      this.categoryCompanyList = const <ForProfitCompany>[],
      this.featuredCompanies = const <ForProfitCompany>[]});

  CompanyListState copyWith(
      {final List<ForProfitCompany>? companies,
      final CompanyListStatus? status,
      final List<ForProfitCompany>? categoryCompanyList,
      final bool? categoryChange,
      final List<ForProfitCompany>? featuredCompanies}) {
    return CompanyListState(
        companies: companies ?? this.companies, status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        companies,
        status,
        categoryCompanyList,
        featuredCompanies,
        categoryChange
      ];
}

class CompanyListFailed extends CompanyListState {}
