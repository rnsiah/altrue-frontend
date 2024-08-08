import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonprofit_proj_repository.dart';

part 'add_np_project_event.dart';
part 'add_np_project_state.dart';

class AddNpProjectBloc extends Bloc<AddNpProjectEvent, AddNpProjectState> {
  NonprofitProjectRepository nonProfitProjectRepoisitory =
      NonprofitProjectRepository();
  AddNpProjectBloc() : super(const AddNpProjectState()) {
    on<NpProjectAtrocityEdited>(_npProjectAtrocityEdited);
    on<NpProjectCategoryEdited>(_npProjectCategoryEdited);
    on<NpProjectFundraisingGoalEdited>(_npProjectFundraisingGoalEdited);
    on<NpProjectTitleEdited>(_npProjectTitleEdited);
    on<NpProjectSubmitted>(_npProjectSubmitted);
    on<NpProjectSuppliesEdited>(_npProjectSuppliesEdited);
    on<NpProjectInformationEdited>(_npProjectInformationEdited);
    on<NpProjectImageSelected>(_npProjectImageSelected);
  }

  void _npProjectAtrocityEdited(
      NpProjectAtrocityEdited event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;

    emit(state.copyWith(atrocity: event.atrocity));
  }

  void _npProjectInformationEdited(
      NpProjectInformationEdited event, Emitter<AddNpProjectState> emit) {
    AddNpProjectState state = this.state;
    String info = event.information;
    AddNpProjectState newState = state.copyWith(information: info);
    emit(newState);
  }

  void _npProjectCategoryEdited(
      NpProjectCategoryEdited event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;
    emit(state.copyWith(category: event.category));
  }

  void _npProjectSuppliesEdited(
      NpProjectSuppliesEdited event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;
    String supplies = event.supplies;
    AddNpProjectState newState = state.copyWith(supplies: supplies);
    emit(newState);
  }

  void _npProjectFundraisingGoalEdited(NpProjectFundraisingGoalEdited event,
      Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;
    int goal = event.fundraisingGoal;
    AddNpProjectState newState = state.copyWith(
      fundraisingGoal: goal,
    );
    emit(newState);
  }

  void _npProjectTitleEdited(
      NpProjectTitleEdited event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;
    String title = event.title;
    AddNpProjectState newState = state.copyWith(title: title);
    emit(newState);
  }

  void _npProjectImageSelected(
      NpProjectImageSelected event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;
    emit(state.copyWith(image: event.imageFile));
  }

  void _npProjectSubmitted(
      NpProjectSubmitted event, Emitter<AddNpProjectState> emit) async {
    AddNpProjectState state = this.state;

    try {
      print({
        'info:': [state.title, state.information, state.fundraisingGoal]
      });

      var response = await nonProfitProjectRepoisitory.submit(event.project);
      emit(state.copyWith(status: FormSubmitting()));
      if (response == true) {
        emit(state.copyWith(status: SubmissionSuccess()));
      }
    } catch (e) {
      emit(state.copyWith(status: SubmissionFaiiled(e.toString())));
    }
  }
}
