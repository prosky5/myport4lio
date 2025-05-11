import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_event.dart';
import 'package:myport4lio/features/projects/bloc/projects_state.dart';

import '../../../core/repositories/projects_repository.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository repository;

  ProjectsBloc({required this.repository}) : super(const ProjectsInitial()) {
    on<LoadProjects>(_onLoadProjects);
  }

  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    try {
      emit(const ProjectsLoading());
      final projects = await repository.getProjects();
      emit(ProjectsLoaded(projects));
    } catch (e) {
      developer.log(
        'Ошибка при загрузке проектов: $e',
        name: 'ProjectsBloc',
        error: e,
      );

      emit(ProjectsError(e.toString()));
    }
  }
} 