part of 'add_np_project_bloc.dart';

abstract class AddNpProjectEvent extends Equatable {
  const AddNpProjectEvent();

  @override
  List<Object> get props => [];
}

class NpProjectTitleEdited extends AddNpProjectEvent {
  final String title;

  const NpProjectTitleEdited({required this.title});
}

class NpProjectImageSelected extends AddNpProjectEvent {
  final File imageFile; // Use File instead of String
  const NpProjectImageSelected(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class NpProjectCategoryEdited extends AddNpProjectEvent {
  final int category;
  const NpProjectCategoryEdited({required this.category});
}

class NpProjectAtrocityEdited extends AddNpProjectEvent {
  final int atrocity;
  const NpProjectAtrocityEdited({required this.atrocity});
}

class NpProjectFundraisingGoalEdited extends AddNpProjectEvent {
  final int fundraisingGoal;
  const NpProjectFundraisingGoalEdited({required this.fundraisingGoal});
}

class NpProjectSuppliesEdited extends AddNpProjectEvent {
  final String supplies;

  const NpProjectSuppliesEdited({required this.supplies});
}

class NpProjectInformationEdited extends AddNpProjectEvent {
  final String information;
  const NpProjectInformationEdited({required this.information});
}

class NpProjectSubmitted extends AddNpProjectEvent {
  final NonProfitProjectCreation project;
  final NonProfit nonProfit;

  const NpProjectSubmitted({required this.project, required this.nonProfit});
}
