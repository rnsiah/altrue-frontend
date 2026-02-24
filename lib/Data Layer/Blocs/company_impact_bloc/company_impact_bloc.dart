import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_dashboard_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_impact_repository.dart';

part 'company_impact_event.dart';
part 'company_impact_state.dart';

class CompanyImpactBloc extends Bloc<CompanyImpactEvent, CompanyImpactState> {
  final CompanyImpactRepository _repository = CompanyImpactRepository();

  CompanyImpactBloc() : super(const CompanyImpactState()) {
    on<FetchUserImpactStats>(_onFetchUserImpactStats);
    on<FetchCompanyDashboard>(_onFetchCompanyDashboard);
    on<RefreshImpactData>(_onRefreshImpactData);
  }

  Future<void> _onFetchUserImpactStats(
    FetchUserImpactStats event,
    Emitter<CompanyImpactState> emit,
  ) async {
    emit(state.copyWith(status: CompanyImpactStatus.loading));
    
    try {
      final impact = await _repository.getUserImpactStats();
      
      emit(state.copyWith(
        status: CompanyImpactStatus.success,
        userImpact: impact,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyImpactStatus.failure,
        errorMessage: 'Failed to load impact stats: $e',
      ));
    }
  }

  Future<void> _onFetchCompanyDashboard(
    FetchCompanyDashboard event,
    Emitter<CompanyImpactState> emit,
  ) async {
    emit(state.copyWith(status: CompanyImpactStatus.loading));
    
    try {
      final dashboard = await _repository.getCompanyDashboard(event.company.id);
      
      emit(state.copyWith(
        status: CompanyImpactStatus.success,
        companyDashboard: dashboard,
        selectedCompany: event.company,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyImpactStatus.failure,
        errorMessage: 'Failed to load dashboard: $e',
      ));
    }
  }

  Future<void> _onRefreshImpactData(
    RefreshImpactData event,
    Emitter<CompanyImpactState> emit,
  ) async {
    if (state.userImpact != null) {
      add(const FetchUserImpactStats());
    }
    if (state.selectedCompany != null) {
      add(FetchCompanyDashboard(company: state.selectedCompany!));
    }
  }
}
