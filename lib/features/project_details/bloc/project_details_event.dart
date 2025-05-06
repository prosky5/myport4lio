import 'package:equatable/equatable.dart';

abstract class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();
  
  @override
  List<Object> get props => [];
}

class LoadProjectDetails extends ProjectDetailsEvent {
  final int projectId;
  
  const LoadProjectDetails(this.projectId);
  
  @override
  List<Object> get props => [projectId];
} 