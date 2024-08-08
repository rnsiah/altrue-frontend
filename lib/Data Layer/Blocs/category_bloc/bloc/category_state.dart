part of 'category_bloc.dart';

enum CategoryStatus { initial, success, failure }

class CategoryState extends Equatable {
  final List<Category> categoryList;
  final CategoryStatus status;

 const CategoryState(
      {this.categoryList = const <Category>[],
      this.status = CategoryStatus.initial});

  CategoryState copyWith({
    final List<Category>? categoryList,
    final CategoryStatus? status,
  }) {
    return CategoryState(
        categoryList: categoryList ?? this.categoryList,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}
