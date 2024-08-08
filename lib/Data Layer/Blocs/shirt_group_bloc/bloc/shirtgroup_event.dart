part of 'shirtgroup_bloc.dart';

class ShirtgroupEvent extends Equatable {
  const ShirtgroupEvent();

  @override
  List<Object> get props => [];
}

class FetchGroups extends ShirtgroupEvent {}

class PageChangeShirtInfo extends ShirtgroupEvent {
  final Shirt shirt;

  const PageChangeShirtInfo({required this.shirt});
}
