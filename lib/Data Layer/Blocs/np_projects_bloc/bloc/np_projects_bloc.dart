import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonprofit_proj_repository.dart';

import '../../../Models/category_model.dart';

part 'np_projects_event.dart';
part 'np_projects_state.dart';

class NpProjectsBloc extends Bloc<NpProjectsEvent, NpProjectsState> {
  final NonprofitProjectRepository nonprofitProjectRepository;
  NpProjectsBloc({required this.nonprofitProjectRepository}) : super(const NpProjectsState()) {
    on<FetchNpProjectsList>(_fetchProjects);
    on<FetchNpProjectListByCategory>(_fetchProjectsByCategory);
    on<FetchNonProfitProject>(_fetchNonProfitProject);
    on<FetchFeaturedNonProfitProjects>(_fetchFeaturedNonProfitProjects);
    fetchfeaturedProjectsOnLogin();
  }


  void _fetchProjects(FetchNpProjectsList event, Emitter<NpProjectsState> emit)async{
    List<NonProfitProject> projectList = await nonprofitProjectRepository.getProjectList();
    NpProjectsState newState = state.copyWith(projects: projectList);
    emit(newState);
  }

  void _fetchProjectsByCategory(FetchNpProjectListByCategory event, Emitter<NpProjectsState>emit)async{
    NpProjectsState newState = state.copyWith(categoryChange: false);
    emit(newState);

    try{
      List<NonProfitProject>categoryNonProfitProjectList= await nonprofitProjectRepository.getProjectListByCategory(category: event.category);
      if(categoryNonProfitProjectList.isEmpty){
        List<NonProfitProject> allProjects = await nonprofitProjectRepository.getProjectList();
        NpProjectsState newState = state.copyWith(categoryNonProfitProjectList: allProjects,
        categoryChange: true,
        status: NonProfitProjectListStatus.success);
        emit(newState);
      }
      NpProjectsState newState = state.copyWith(categoryNonProfitProjectList: categoryNonProfitProjectList,
      categoryChange: true,
      status:NonProfitProjectListStatus.success );
      emit(newState);
    }catch(e){
      emit(state.copyWith(status: NonProfitProjectListStatus.failure));
      print(e.toString());
    }
  }

  void _fetchNonProfitProject(FetchNonProfitProject event, Emitter<NpProjectsState> emit) async {
    await nonprofitProjectRepository.fetchNonProfitProject(event.project.id!);

  }

  void _fetchFeaturedNonProfitProjects(FetchFeaturedNonProfitProjects event, Emitter<NpProjectsState> emit)async{
    emit(state.copyWith(status: NonProfitProjectListStatus.loading));
    List<NonProfitProject> projects = await nonprofitProjectRepository.fetchFeaturedProjects();
    if(projects.isEmpty){
      emit(state.copyWith(status: NonProfitProjectListStatus.failure));
    }
    NpProjectsState newState = state.copyWith(featuredNonProfitProjects: projects, status: NonProfitProjectListStatus.success);
    emit(newState);
  }


void fetchfeaturedProjectsOnLogin() async {
    emit(const NpProjectsState(status: NonProfitProjectListStatus.initial));
    try {
      List<NonProfitProject> all = await nonprofitProjectRepository.getProjectList();
      List<NonProfitProject> featured = await nonprofitProjectRepository.fetchFeaturedProjects();
      if (featured.isNotEmpty) {
        NpProjectsState newState = state.copyWith(
            projects: all,
            featuredNonProfitProjects: featured,
            status: NonProfitProjectListStatus.success);
        emit(newState);
      }
    } catch (e) {
      print(e.toString());
      NpProjectsState newState = const NpProjectsState(status: NonProfitProjectListStatus.failure);
      emit(newState);
    }
  }
}
// 