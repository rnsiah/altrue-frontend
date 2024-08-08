part of 'np_projects_bloc.dart';

abstract class NpProjectsEvent extends Equatable {
  const NpProjectsEvent();

  @override
  List<Object> get props => [];
}

class FetchNpProjectsList extends NpProjectsEvent{
 final List<NonProfitProject> projects;
 
 const FetchNpProjectsList({required this.projects});
}

class FetchNpProjectListByCategory extends NpProjectsEvent{
  final Category category;
  
 const FetchNpProjectListByCategory({required this.category});
}

class FetchFeaturedNonProfitProjects extends NpProjectsEvent{
  final List<NonProfitProject> projects;
  const FetchFeaturedNonProfitProjects({required this.projects});
}

class FetchNonProfitProject extends NpProjectsEvent{
  final NonProfitProject project;

 const FetchNonProfitProject({required this.project});
}
