import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();
  
  @override
  List<Object> get props => [];
}

class LoadProjects extends ProjectsEvent {
  const LoadProjects();
}

class RefreshProjects extends ProjectsEvent {
  const RefreshProjects();
} 