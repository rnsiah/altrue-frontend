part of 'create_company_bloc.dart';

class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();

  @override
  List<Object> get props => [];
}

class CompanyNameChange extends CreateCompanyEvent {
  final String companyName;

  const CompanyNameChange({required this.companyName});

  @override
  List<Object> get props => [companyName];
}

class CompanyDescriptionChange extends CreateCompanyEvent {
  final String companyDescription;

  const CompanyDescriptionChange({required this.companyDescription});

  List<Object> get props => [companyDescription];
}

class CompanyWebsiteChange extends CreateCompanyEvent {
  final String companyWebsite;

  CompanyWebsiteChange({required this.companyWebsite});

  List<Object> get props => [companyWebsite];
}

class CompanyAddressChange extends CreateCompanyEvent {
  final String companyAddress;

  CompanyAddressChange({required this.companyAddress});
  @override
  List<Object> get props => [companyAddress];
}

class CompanyInstagramChange extends CreateCompanyEvent {
  final String comInsta;

  CompanyInstagramChange({required this.comInsta});

  @override
  List<Object> get props => [comInsta];
}

class CompanyFacebookChange extends CreateCompanyEvent {
  final String comFacebook;

  CompanyFacebookChange({required this.comFacebook});

  @override
  List<Object> get props => [comFacebook];
}

class CompanyYearStartedChanged extends CreateCompanyEvent {
  final String companyYear;

  CompanyYearStartedChanged({required this.companyYear});

  @override
  List<Object> get props => [companyYear];
}

class CompanyMissionChanged extends CreateCompanyEvent {
  final String mission;
  CompanyMissionChanged({required this.mission});

  @override
  List<Object> get props => [mission];
}

class CompanyLogoChanged extends CreateCompanyEvent {
  final dynamic logo;

  CompanyLogoChanged({required this.logo});

  @override
  List<Object> get props => [logo];
}

class CompanyMainImageChange extends CreateCompanyEvent {
  final dynamic compMainImage;

  CompanyMainImageChange({required this.compMainImage});

  @override
  List<Object> get props => [compMainImage];
}

class CompanyAttemptCreate extends CreateCompanyEvent {
  final Profile profile;
  final CompanyCompletion completedCompany;

  CompanyAttemptCreate({required this.completedCompany, required this.profile});

  @override
  List<Object> get props => [profile, completedCompany];
}

class CompanyFailedRegistration extends CreateCompanyEvent {
  final String errorMessage;

  CompanyFailedRegistration({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
