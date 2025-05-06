import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/project.dart';

enum ProjectsStatus { initial, loading, loaded, error }

class ProjectsState extends Equatable {
  final ProjectsStatus status;
  final List<Project> projects;
  final String? errorMessage;
  
  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.projects = const [],
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [status, projects, errorMessage];
  
  ProjectsState copyWith({
    ProjectsStatus? status,
    List<Project>? projects,
    String? errorMessage,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 