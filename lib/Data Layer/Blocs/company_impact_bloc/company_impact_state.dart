part of 'company_impact_bloc.dart';

enum CompanyImpactStatus { initial, loading, success, failure }

class CompanyImpactState extends Equatable {
  final CompanyImpactStatus status;
  final String? errorMessage;
  final UserCompanyImpact? userImpact;
  final CompanyDashboard? companyDashboard;
  final ForProfitCompany? selectedCompany;

  const CompanyImpactState({
    this.status = CompanyImpactStatus.initial,
    this.errorMessage,
    this.userImpact,
    this.companyDashboard,
    this.selectedCompany,
  });

  CompanyImpactState copyWith({
    CompanyImpactStatus? status,
    String? errorMessage,
    UserCompanyImpact? userImpact,
    CompanyDashboard? companyDashboard,
    ForProfitCompany? selectedCompany,
  }) {
    return CompanyImpactState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userImpact: userImpact ?? this.userImpact,
      companyDashboard: companyDashboard ?? this.companyDashboard,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        userImpact,
        companyDashboard,
        selectedCompany,
      ];
}
