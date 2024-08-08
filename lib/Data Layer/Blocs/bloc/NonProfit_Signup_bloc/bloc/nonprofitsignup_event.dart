part of 'nonprofitsignup_bloc.dart';

class NonprofitsignupEvent extends Equatable {
  NonprofitsignupEvent();

  @override
  List<Object> get props => [];
}

class NonProfitNameChangeOnForm extends NonprofitsignupEvent {
  final String npName;

  NonProfitNameChangeOnForm({required this.npName});

  @override
  List<Object> get props => [npName];
}

class NonProfitAddressChangeOnForm extends NonprofitsignupEvent {
  final String npAddress;
  NonProfitAddressChangeOnForm({required this.npAddress});

  @override
  List<Object> get props => [npAddress];
}

class NonProfitInstagramChangeOnForm extends NonprofitsignupEvent {
  final String npInstagram;

  NonProfitInstagramChangeOnForm({required this.npInstagram});

  @override
  List<Object> get props => [npInstagram];
}

class NonProfitFacebookChangeOnForm extends NonprofitsignupEvent {
  final String npFacebook;

  NonProfitFacebookChangeOnForm({required this.npFacebook});

  @override
  List<Object> get props => [npFacebook];
}

class NonProfitStateChangeOnForm extends NonprofitsignupEvent {
  final String npState;
  NonProfitStateChangeOnForm({required this.npState});

  @override
  List<Object> get props => [npState];
}

class NonProfitMissionStatementChangeOnForm extends NonprofitsignupEvent {
  final String npMission;

  NonProfitMissionStatementChangeOnForm({required this.npMission});

  @override
  List<Object> get props => [npMission];
}

class NonProfitVisionStatementChangeOnForm extends NonprofitsignupEvent {
  final String npVision;

  NonProfitVisionStatementChangeOnForm({required this.npVision});

  @override
  List<Object> get props => [npVision];
}

class NonProfitWebsiteChangeOnForm extends NonprofitsignupEvent {
  final String npWebsite;

  NonProfitWebsiteChangeOnForm({required this.npWebsite});
  @override
  List<Object> get props => [npWebsite];
}

class NonProfitDescriptionChangeOnForm extends NonprofitsignupEvent {
  final String npDescription;

  NonProfitDescriptionChangeOnForm({required this.npDescription});

  @override
  List<Object> get props => [npDescription];
}

class NonProfitLogoChangeOnForm extends NonprofitsignupEvent {
  final Image  npLogo;

  NonProfitLogoChangeOnForm({required this.npLogo});

  @override
  List<Object> get props => [];
}

class NonProfitMainImageChangeOnForm extends NonprofitsignupEvent {
  final dynamic npMainImage;

  NonProfitMainImageChangeOnForm({required this.npMainImage});

  @override
  List<Object> get props => [npMainImage];
}

class NonProfitYearStartedChangeOnForm extends NonprofitsignupEvent {
  final int npYearStarted;

  NonProfitYearStartedChangeOnForm({required this.npYearStarted});

  @override
  List<Object> get props => [npYearStarted];
}

class NonProfitSignUpFormCompletion extends NonprofitsignupEvent {
  final NonProfitCompletion nonprofit;
  final Profile profile;

  NonProfitSignUpFormCompletion(
      {required this.nonprofit, required this.profile});

  @override
  List<Object> get props => [nonprofit, profile];
}

class NonProfitCreationError extends NonprofitsignupEvent {
  final String errorMessage;
  NonProfitCreationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
