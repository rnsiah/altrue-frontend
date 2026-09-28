import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import '../../../Models/company_completion_model.dart';

part 'create_company_event.dart';
part 'create_company_state.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyState> {
  final CompanyRepository companyRepository = CompanyRepository();
  final UserRepository userRepository = UserRepository();

  CreateCompanyBloc() : super(CreateCompanyState()) {
    on<CompanyAddressChange>(_companyAddressChange);
    on<CompanyFacebookChange>(_companyFacebookChange);
    on<CompanyInstagramChange>(_companyInstagramChange);
    on<CompanyNameChange>(_companyNameChange);
    on<CompanyYearStartedChanged>(_companyYearStartedChange);
    on<CompanyMissionChanged>(_companyMissionChange);
    on<CompanyLogoChanged>(_companyLogoChange);
    on<CompanyDescriptionChange>(_companyDescriptionChange);
    on<CompanyMainImageChange>(_companyMainImageChange);
    on<CompanyWebsiteChange>(_companyWebsiteChange);
    on<CompanyAttemptCreate>(_companyAttemptCreate);
  }

  void _companyAddressChange(
      CompanyAddressChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(companyAddress: event.companyAddress));
  }

  void _companyFacebookChange(
      CompanyFacebookChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(facebook: event.comFacebook));
  }

  void _companyInstagramChange(
      CompanyInstagramChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(instagram: event.comInsta));
  }

  void _companyNameChange(
      CompanyNameChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(companyName: event.companyName));
  }

  void _companyYearStartedChange(
      CompanyYearStartedChanged event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(yearStarted: event.companyYear));
  }

  void _companyMissionChange(
      CompanyMissionChanged event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(mission: event.mission));
  }

  void _companyLogoChange(
      CompanyLogoChanged event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(logo: event.logo));
  }

  void _companyDescriptionChange(
      CompanyDescriptionChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(description: event.companyDescription));
  }

  void _companyMainImageChange(
      CompanyMainImageChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(mainImage: event.compMainImage));
  }

  void _companyWebsiteChange(
      CompanyWebsiteChange event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(website: event.companyWebsite));
  }

  void _companyAttemptCreate(
      CompanyAttemptCreate event, Emitter<CreateCompanyState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      User? user = await userRepository.userDao.getCurrentUser(0);
      CompanyCompletion company = CompanyCompletion(
        profile: state.profile!,
        companyAddress: state.companyAddress,
        companyName: state.companyName,
        description: state.description,
        instagram: state.instagram,
        facebook: state.facebook,
        wehsite: state.wehsite,
        logo: state.logo,
        mainImage: state.mainImage,
        missionStatement: state.mission,
        yearStarted: state.yearStarted,
        userId: user!.id,
      );
      await companyRepository.newCompany(company: company, user: user);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }
}
