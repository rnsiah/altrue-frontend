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
  final FormSubmissionStatus status;

  const AddNpProjectState(
      {this.information = '',
      this.atrocity,
      this.category,
      this.fundraisingGoal = 0,
      this.supplies = '',
      this.title = '',
      this.image,
      this.status = const InitialFormStatus()});

  AddNpProjectState copyWith({
    String? title,
    String? supplies,
    String? information,
    int? fundraisingGoal,
    int? atrocity,
    int? category,
    File? image,
    FormSubmissionStatus? status,
  }) {
    return AddNpProjectState(
        title: title ?? this.title,
        supplies: supplies ?? this.supplies,
        information: information ?? this.information,
        fundraisingGoal: fundraisingGoal ?? this.fundraisingGoal,
        category: category ?? this.category,
        status: status ?? this.status,
        image: image ?? this.image);
  }

  @override
  List<Object> get props => [information, title, fundraisingGoal, supplies];
}

class AddNpProjectInitial extends AddNpProjectState {}
