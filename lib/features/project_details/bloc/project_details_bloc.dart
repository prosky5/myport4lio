import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/repositories/projects_repository.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_event.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final ProjectsRepository repository;
  
  ProjectDetailsBloc({required this.repository}) : super(const ProjectDetailsState()) {
    on<LoadProjectDetails>(_onLoadProjectDetails);
  }
  
  Future<void> _onLoadProjectDetails(
    LoadProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProjectDetailsStatus.loading));
    
    try {
      final project = await repository.getProjectById(event.projectId);
      emit(state.copyWith(
        status: ProjectDetailsStatus.loaded,
        project: project,
      ));
    } catch (e) {
      developer.log(
        'Ошибка при загрузке деталей проекта (ID: ${event.projectId}): $e',
        name: 'ProjectDetailsBloc',
        error: e,
      );
      emit(state.copyWith(
        status: ProjectDetailsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
} 