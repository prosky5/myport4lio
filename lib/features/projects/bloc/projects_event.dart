import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadProjects extends ProjectsEvent {}

class LoadProjectById extends ProjectsEvent {
  final String id;

  const LoadProjectById(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshProjects extends ProjectsEvent {
  const RefreshProjects();
} 