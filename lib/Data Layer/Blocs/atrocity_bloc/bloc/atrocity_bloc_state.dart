part of 'atrocity_bloc_bloc.dart';

enum AtrocityStatus { initial, success, failure }

class AtrocityBlocState extends Equatable {
  final AtrocityStatus status;
  final List<Atrocity> atrocities;
  final List<Atrocity> featuredAtrocities;
  final List<Atrocity> atrocityCategoryList;
  final bool categoryChange;

  const AtrocityBlocState(
      {this.status = AtrocityStatus.initial,
      this.atrocityCategoryList = const <Atrocity>[],
      this.categoryChange = false,
      this.featuredAtrocities = const <Atrocity>[],
      this.atrocities = const <Atrocity>[]});

  AtrocityBlocState copyWith(
      {final AtrocityStatus? status,
      final List<Atrocity>? atrocityCategoryList,
      final bool? categoryChange,
      final List<Atrocity>? atrocities,
      final List<Atrocity>? featuredAtrocities}) {
    return AtrocityBlocState(
        categoryChange: categoryChange ?? this.categoryChange,
        atrocityCategoryList: atrocityCategoryList ?? this.atrocityCategoryList,
        status: status ?? this.status,
        atrocities: atrocities ?? this.atrocities,
        featuredAtrocities: featuredAtrocities ?? this.atrocities);
  }

  @override
  List<Object> get props => [
        status,
        atrocities,
        featuredAtrocities,
        atrocityCategoryList,
        categoryChange
      ];
}
