part of 'atrocity_bloc_bloc.dart';

abstract class AtrocityBlocEvent extends Equatable {
  const AtrocityBlocEvent();

  @override
  List<Object> get props => [];
}

class AtrocityListFetched extends AtrocityBlocEvent {
  const AtrocityListFetched();
  @override
  List<Object> get props => [];
}

class AtrocityItemFteched extends AtrocityBlocEvent {
  final Atrocity atrocity;

  const AtrocityItemFteched({required this.atrocity});

  @override
  List<Object> get props => [atrocity];
}

class AtrocityListFetchedByCategory extends AtrocityBlocEvent {
  final Category category;

  const AtrocityListFetchedByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class FeaturedAtrocityListFetched extends AtrocityBlocEvent {
  final User user;
  const FeaturedAtrocityListFetched({required this.user});
}
