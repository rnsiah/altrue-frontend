part of 'shirtgroup_bloc.dart';

enum ShirtGroupStatus { initial, success, failure }

class ShirtgroupState extends Equatable {
  final ShirtGroupStatus status;
  final List<ShirtGroup> shirtgroups;
  final Shirt? shirt;

  const ShirtgroupState(
      {this.shirtgroups = const <ShirtGroup>[],
      this.shirt,
      this.status = ShirtGroupStatus.initial});

  ShirtgroupState copyWith(
      {final ShirtGroupStatus? status,
      final List<ShirtGroup>? shirtgroups,
      final Shirt? shirt}) {
    return ShirtgroupState(
        shirtgroups: shirtgroups ?? this.shirtgroups,
        shirt: shirt ?? this.shirt,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [shirtgroups, status];
}

class ShirtgroupInitial extends ShirtgroupState {}

class ShirtChanging extends ShirtgroupState {}
