part of 'nonprofitsignup_bloc.dart';

class NonprofitsignupState extends Equatable {
  final Profile? profile;
  final int? yearStarted;
  final String name;
  final String address;
  final String state;
  final String missionStatement;
  final String visionStatement;
  final String facebook;
  final String website;
  final String instagram;
  final String description;
  // final dynamic logo;
  // final dynamic mainImage;
  final FormSubmissionStatus status;
  NonprofitsignupState(
      {this.address = '',
      this.yearStarted = 1999,
      this.name = '',
      this.description = '',
      this.facebook = '',
      this.instagram = '',
      this.state = '',
      this.missionStatement = '',
      this.status = const InitialFormStatus(),
      this.visionStatement = '',
      this.website = '',
      // this.logo,
      // this.mainImage,
      this.profile});

  NonprofitsignupState copyWith({
    String? address,
    String? name,
    String? description,
    String? facebook,
    String? instagram,
    String? state,
    String? missionStatement,
    String? visionStatement,
    String? website,
    // dynamic logo,
    // dynamic mainImage,
    int? yearStarted,
    Profile? profile,
    FormSubmissionStatus? status,
  }) {
    return NonprofitsignupState(
        name: name ?? this.name,
        yearStarted: yearStarted ?? this.yearStarted,
        profile: profile ?? this.profile,
        address: address ?? this.address,
        description: description ?? this.description,
        facebook: facebook ?? this.facebook,
        state: state ?? this.state,
        missionStatement: missionStatement ?? this.missionStatement,
        visionStatement: visionStatement ?? this.visionStatement,
        // logo: logo ?? this.logo,
        // mainImage: mainImage ?? this.mainImage,
        status: status ?? this.status,
        website: website ?? this.website);
  }

  @override
  List<Object> get props => [
        address,
        description,
        // logo,
        visionStatement,
        missionStatement,
        state,
        // mainImage,
        website,
        facebook,
        instagram,
        name
      ];
}
