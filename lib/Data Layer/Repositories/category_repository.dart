import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';

import '../Models/quiz_model.dart';

class CategoryRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<Category>> fetchCatgegories() async {
    List<Category> categories = [];

    final response = await _provider.get('api/categories/');
    for (var incomingcategory in response) {
      categories.add(Category.fromJson(incomingcategory));
    }
    return categories;
  }

  Future<Category> fetchCategory(int id) async {
    final response = await _provider.get('api/categories/$id/');
    return Category.fromJson(response);
  }

  Future<List<Quiz>> fetchQuizList(Category category) async{
    List<Quiz> quizList =<Quiz>[];
    final response = await _provider.get('api/quizes/filter_by_category/?category_pk=${category.id}');
    print(response);
    for(var incomingQuiz in response){
      print(incomingQuiz);
      quizList.add(Quiz.fromJson(incomingQuiz));
    }
    
    return quizList;

  }
}
