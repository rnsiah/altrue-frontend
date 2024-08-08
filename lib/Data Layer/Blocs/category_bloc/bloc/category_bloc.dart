import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    on<FetchCategory>(_fetchCategories);
  }

  void _fetchCategories(
      FetchCategory event, Emitter<CategoryState> emit) async {
    List<Category> categoryList = await categoryRepository.fetchCatgegories();
    emit(state.copyWith(categoryList: categoryList));
  }
}
