import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/project.dart';

sealed class ProjectDetailsState extends Equatable {
  const ProjectDetailsState();

  @override
  List<Object?> get props => [];

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(Project project) loaded,
    required T Function(String message) error,
  }) {
    return switch (this) {
      ProjectDetailsInitial() => initial(),
      ProjectDetailsLoading() => loading(),
      ProjectDetailsLoaded(project: final project) => loaded(project),
      ProjectDetailsError(message: final msg) => error(msg),
    };
  }
}

class ProjectDetailsInitial extends ProjectDetailsState {
  const ProjectDetailsInitial();
}

class ProjectDetailsLoading extends ProjectDetailsState {
  const ProjectDetailsLoading();
}

class ProjectDetailsLoaded extends ProjectDetailsState {
  final Project project;

  const ProjectDetailsLoaded(this.project);

  @override
  List<Object?> get props => [project];
}

class ProjectDetailsError extends ProjectDetailsState {
  final String message;

  const ProjectDetailsError(this.message);

  @override
  List<Object?> get props => [message];
} 