import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/repositories/projects_repository.dart';
import 'package:myport4lio/features/projects/bloc/projects_event.dart';
import 'package:myport4lio/features/projects/bloc/projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository repository;
  
  ProjectsBloc({required this.repository}) : super(const ProjectsState()) {
    on<LoadProjects>(_onLoadProjects);
    on<RefreshProjects>(_onRefreshProjects);
  }
  
  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    if (state.status == ProjectsStatus.loaded) return;
    
    emit(state.copyWith(status: ProjectsStatus.loading));
    
    try {
      final projects = await repository.getProjects();
      emit(state.copyWith(
        status: ProjectsStatus.loaded,
        projects: projects,
      ));
    } catch (e) {
      developer.log(
        'Ошибка при загрузке проектов: $e',
        name: 'ProjectsBloc',
        error: e,
      );
      emit(state.copyWith(
        status: ProjectsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  
  Future<void> _onRefreshProjects(
    RefreshProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(status: ProjectsStatus.loading));
    
    try {
      final projects = await repository.getProjects();
      emit(state.copyWith(
        status: ProjectsStatus.loaded,
        projects: projects,
      ));
    } catch (e) {
      developer.log(
        'Ошибка при обновлении проектов: $e',
        name: 'ProjectsBloc',
        error: e,
      );
      emit(state.copyWith(
        status: ProjectsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
} 