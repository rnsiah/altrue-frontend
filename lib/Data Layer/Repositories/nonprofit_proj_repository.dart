import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class NonprofitProjectRepository {
  ApiProvider apiProvider = ApiProvider();
  NonAuthenticatedApiProvider nonAuthProvider = NonAuthenticatedApiProvider();
  UserRepository userRepository = UserRepository();

  Future<dynamic> submit(NonProfitProjectCreation npProject) async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    final response = apiProvider.postAuthenticatedData(
        url: 'api/createProject/', key:user!.key!, altId:user.altid!, data:npProject);
    return response;
  }

  Future<List<NonProfitProject>>getProjectList()async{
    List <NonProfitProject> projects =[];
    final response = await nonAuthProvider.get('api/projects');
    for(var responses in response){
      projects.add(NonProfitProject.fromJson(responses));
    }
    return projects;

  }

  Future<List<NonProfitProject>>getProjectListByCategory({required Category category})async{
    List<NonProfitProject> projects= [];
    final response = await nonAuthProvider.get('api/projects/?cat=${category.id}');
    for (var responses in response){
      projects.add(NonProfitProject.fromJson(responses));
    }
    return projects;
  }

  Future<NonProfitProject>fetchNonProfitProject(int id)async{
    final response = await nonAuthProvider.get('api/projects/$id');
    NonProfitProject pro = NonProfitProject.fromJson(response);
    return pro;
  }


  Future<List<NonProfitProject>> fetchFeaturedProjects()async{
    List<NonProfitProject> projects =[];
    final response = await nonAuthProvider.get('api/featuredProjects');
    for(var responses in response){
      projects.add(NonProfitProject.fromJson(responses));
    }
    return projects;
  }

  
}
