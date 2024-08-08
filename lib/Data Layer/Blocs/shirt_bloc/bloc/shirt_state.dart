part of 'shirt_bloc.dart';

enum ShirtStatus { initial, successful, failure }

class ShirtState extends Equatable {
  final List<Shirt> shirtlist;
  final List<Shirt> featuredShirts;
  final ShirtStatus status;
  final List<Shirt> categoryShirtList;
  final bool categoryChange;

  const ShirtState(
      {this.shirtlist = const <Shirt>[],
      this.categoryChange = false,
      this.categoryShirtList = const <Shirt>[],
      this.status = ShirtStatus.initial,
      this.featuredShirts = const <Shirt>[]});

  ShirtState copyWith(
      {List<Shirt>? shirtlist,
      ShirtStatus? status,
      List<Shirt>? featuredShirts,
      List<Shirt>? categoryShirtList,
      bool? categoryChange}) {
    return ShirtState(
        categoryChange: categoryChange ?? this.categoryChange,
        categoryShirtList: categoryShirtList ?? this.categoryShirtList,
        shirtlist: shirtlist ?? this.shirtlist,
        status: status ?? this.status,
        featuredShirts: featuredShirts ?? this.featuredShirts);
  }

  @override
  List<Object> get props =>
      [shirtlist, status, categoryShirtList, featuredShirts, categoryChange];
}

class ShirStateChange extends Equatable {
  @override
  List<Object?> get props => [];
}
