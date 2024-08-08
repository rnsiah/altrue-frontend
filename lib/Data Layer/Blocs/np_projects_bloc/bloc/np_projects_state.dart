part of 'np_projects_bloc.dart';

enum NonProfitProjectListStatus { initial, loading, success, failure }

class NpProjectsState extends Equatable {
  const NpProjectsState(
      {this.projects = const <NonProfitProject>[],
      this.status = NonProfitProjectListStatus.initial,
      this.categoryChange = false,
      this.categoryNonProfitProjectList = const <NonProfitProject>[],
      this.featuredNonProfitProjects = const <NonProfitProject>[]});

  final List<NonProfitProject> projects;
  final NonProfitProjectListStatus status;
  final List<NonProfitProject> categoryNonProfitProjectList;
  final bool categoryChange;
  final List<NonProfitProject> featuredNonProfitProjects;

  NpProjectsState copyWith(
      {final List<NonProfitProject>? projects,
      final NonProfitProjectListStatus? status,
      final List<NonProfitProject>? categoryNonProfitProjectList,
      final bool? categoryChange,
      final List<NonProfitProject>? featuredNonProfitProjects}) {
    return NpProjectsState(
        categoryChange: categoryChange ?? this.categoryChange,
        projects: projects ?? this.projects,
        categoryNonProfitProjectList:
            categoryNonProfitProjectList ?? this.categoryNonProfitProjectList,
        status: status ?? this.status,
        featuredNonProfitProjects:
            featuredNonProfitProjects ?? this.featuredNonProfitProjects);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    projects,
    status,
    categoryChange,
    categoryNonProfitProjectList,
    featuredNonProfitProjects
  ];
}

class NpProjectsInitial extends NpProjectsState {}
