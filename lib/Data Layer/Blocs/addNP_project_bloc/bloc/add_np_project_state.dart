part of 'add_np_project_bloc.dart';

enum AddNpProjectStatus { Initial, Submitted, Failed }

class AddNpProjectState extends Equatable {
  final String title;
  final String information;
  final int fundraisingGoal;
  final int? atrocity;
  final int? category;
  final String supplies;
  final File? image;
  final FormSubmissionStatus formStatus;

  const AddNpProjectState(
      {this.information = '',
      this.atrocity,
      this.category,
      this.fundraisingGoal = 0,
      this.supplies = '',
      this.title = '',
      this.image,
      this.formStatus = const InitialFormStatus()});

  AddNpProjectState copyWith({
    String? title,
    String? supplies,
    String? information,
    int? fundraisingGoal,
    int? atrocity,
    int? category,
    File? image,
    FormSubmissionStatus? formStatus,
  }) {
    return AddNpProjectState(
        title: title ?? this.title,
        supplies: supplies ?? this.supplies,
        information: information ?? this.information,
        fundraisingGoal: fundraisingGoal ?? this.fundraisingGoal,
        category: category ?? this.category,
        formStatus: formStatus ?? this.formStatus,
        image: image ?? this.image);
  }

  @override
  List<Object> get props => [information, title, fundraisingGoal, supplies];
}

class AddNpProjectInitial extends AddNpProjectState {}
