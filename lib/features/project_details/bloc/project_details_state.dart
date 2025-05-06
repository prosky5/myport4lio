import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/project.dart';

enum ProjectDetailsStatus { initial, loading, loaded, error }

class ProjectDetailsState extends Equatable {
  final ProjectDetailsStatus status;
  final Project? project;
  final String? errorMessage;
  
  const ProjectDetailsState({
    this.status = ProjectDetailsStatus.initial,
    this.project,
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [status, project, errorMessage];
  
  ProjectDetailsState copyWith({
    ProjectDetailsStatus? status,
    Project? project,
    String? errorMessage,
  }) {
    return ProjectDetailsState(
      status: status ?? this.status,
      project: project ?? this.project,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 