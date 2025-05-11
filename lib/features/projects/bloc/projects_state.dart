import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/project.dart';

sealed class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => [];

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Project> projects) loaded,
    required T Function(String message) error,
  }) {
    return switch (this) {
      ProjectsInitial() => initial(),
      ProjectsLoading() => loading(),
      ProjectsLoaded(projects: final projects) => loaded(projects),
      ProjectsError(message: final msg) => error(msg),
    };
  }
}

class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  const ProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

class ProjectsError extends ProjectsState {
  final String message;

  const ProjectsError(this.message);

  @override
  List<Object?> get props => [message];
} 