part of 'create_company_bloc.dart';

class CreateCompanyState extends Equatable {
  final String companyName;
  final Profile? profile;
  final String mission;
  final String companyAddress;
  final String description;
  final String facebook;
  final String instagram;
  final String logo;
  final String wehsite;
  final String yearStarted;
  final FormSubmissionStatus? formStatus;
  final String mainImage;
  CreateCompanyState(
      {this.profile,
      this.logo = '',
      this.mainImage='',
      this.formStatus = const InitialFormStatus(),
      this.wehsite = '',
      this.companyAddress = '',
      this.companyName = '',
      this.description = '',
      this.facebook = '',
      this.instagram = '',
      this.mission = '',
      this.yearStarted = ''});

  CreateCompanyState copyWith(
      {String? companyAddress,
      String? companyName,
      String? website,
      String? description,
      String? facebook,
      String? instagram,
      dynamic logo,
      dynamic mainImage,
      String? yearStarted,
      Profile? profile,
      String? mission,
      FormSubmissionStatus? formStatus}) {
    return CreateCompanyState(
        companyAddress: companyAddress ?? this.companyAddress,
        wehsite: website ?? this.wehsite,
        companyName: companyName ?? this.companyName,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        mission: mission ?? this.mission,
        description: description ?? this.description,
        profile: profile ?? this.profile,
        yearStarted: yearStarted ?? this.yearStarted,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object> get props => [
        companyAddress,
        companyName,
        facebook,
        instagram,
        wehsite,
        mission,
        description,
        yearStarted,
      ];
}

class CreateCompanyInitial extends CreateCompanyState {}
