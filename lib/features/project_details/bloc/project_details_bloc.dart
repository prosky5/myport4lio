import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_event.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_state.dart';

import '../../../core/repositories/projects_repository.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final ProjectsRepository repository;
  
  ProjectDetailsBloc({required this.repository}) : super(const ProjectDetailsInitial()) {
    on<LoadProjectDetails>(_onLoadProjectDetails);
  }
  
  Future<void> _onLoadProjectDetails(
    LoadProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    try {
      emit(const ProjectDetailsLoading());
      final project = await repository.getProjectById(event.projectId);
      emit(ProjectDetailsLoaded(project));
    } catch (e) {
      developer.log(
        'Ошибка при загрузке деталей проекта: $e',
        name: 'ProjectDetailsBloc',
        error: e,
      );

      emit(ProjectDetailsError(e.toString()));
    }
  }
} 