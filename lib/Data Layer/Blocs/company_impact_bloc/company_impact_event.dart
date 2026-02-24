part of 'company_impact_bloc.dart';

abstract class CompanyImpactEvent extends Equatable {
  const CompanyImpactEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserImpactStats extends CompanyImpactEvent {
  const FetchUserImpactStats();
}

class FetchCompanyDashboard extends CompanyImpactEvent {
  final ForProfitCompany company;

  const FetchCompanyDashboard({required this.company});

  @override
  List<Object?> get props => [company];
}

class RefreshImpactData extends CompanyImpactEvent {
  const RefreshImpactData();
}
