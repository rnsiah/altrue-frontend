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
  @override
  List<Object> get props => [companyDescription];
}

class CompanyWebsiteChange extends CreateCompanyEvent {
  final String companyWebsite;

  const CompanyWebsiteChange({required this.companyWebsite});

  @override
  List<Object> get props => [companyWebsite];
}

class CompanyAddressChange extends CreateCompanyEvent {
  final String companyAddress;

  const CompanyAddressChange({required this.companyAddress});
  @override
  List<Object> get props => [companyAddress];
}

class CompanyInstagramChange extends CreateCompanyEvent {
  final String comInsta;

  const CompanyInstagramChange({required this.comInsta});

  @override
  List<Object> get props => [comInsta];
}

class CompanyFacebookChange extends CreateCompanyEvent {
  final String comFacebook;

  const CompanyFacebookChange({required this.comFacebook});

  @override
  List<Object> get props => [comFacebook];
}

class CompanyYearStartedChanged extends CreateCompanyEvent {
  final String companyYear;

  const CompanyYearStartedChanged({required this.companyYear});

  @override
  List<Object> get props => [companyYear];
}

class CompanyMissionChanged extends CreateCompanyEvent {
  final String mission;
  const CompanyMissionChanged({required this.mission});

  @override
  List<Object> get props => [mission];
}

class CompanyLogoChanged extends CreateCompanyEvent {
  final dynamic logo;

  const CompanyLogoChanged({required this.logo});

  @override
  List<Object> get props => [logo];
}

class CompanyMainImageChange extends CreateCompanyEvent {
  final dynamic compMainImage;

  const CompanyMainImageChange({required this.compMainImage});

  @override
  List<Object> get props => [compMainImage];
}

class CompanyAttemptCreate extends CreateCompanyEvent {
  final Profile profile;
  final CompanyCompletion completedCompany;

  const CompanyAttemptCreate({required this.completedCompany, required this.profile});

  @override
  List<Object> get props => [profile, completedCompany];
}

class CompanyFailedRegistration extends CreateCompanyEvent {
  final String errorMessage;

  const CompanyFailedRegistration({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
