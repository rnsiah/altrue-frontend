import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';

import '../../../Models/shirt_group_model.dart';
import '../../../Repositories/shirt_groups_repository.dart';

part 'shirtgroup_event.dart';
part 'shirtgroup_state.dart';

class ShirtgroupBloc extends Bloc<ShirtgroupEvent, ShirtgroupState> {
  final ShirtGroupRepository shirtGroupRepository;
  ShirtgroupBloc({required this.shirtGroupRepository})
      : super(ShirtgroupInitial()) {
    on<FetchGroups>(_fetchGroups);
    on<PageChangeShirtInfo>(_onChange);
  }

  void _fetchGroups(FetchGroups event, Emitter<ShirtgroupState> emit) async {
    List<ShirtGroup> groups = await shirtGroupRepository.getShirtGroups();
    emit(state.copyWith(shirtgroups: groups));
  }

  void _onChange(
      PageChangeShirtInfo event, Emitter<ShirtgroupState> emit) async {
    ShirtgroupState newState = state;
    emit(ShirtChanging());

    Shirt newShirt = event.shirt;
    List<ShirtGroup> groups = await shirtGroupRepository.getShirtGroups();
    emit(state.copyWith(shirtgroups: groups, shirt: newShirt));
  }
}
