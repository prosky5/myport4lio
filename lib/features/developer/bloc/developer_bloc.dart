import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/repositories/developer_repository.dart';
import 'package:myport4lio/features/developer/bloc/developer_event.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';

class DeveloperBloc extends Bloc<DeveloperEvent, DeveloperState> {
  final DeveloperRepository repository;
  
  DeveloperBloc({required this.repository}) : super(const DeveloperState()) {
    on<LoadDeveloperInfo>(_onLoadDeveloperInfo);
    on<RefreshDeveloperInfo>(_onRefreshDeveloperInfo);
  }
  
  Future<void> _onLoadDeveloperInfo(
    LoadDeveloperInfo event,
    Emitter<DeveloperState> emit,
  ) async {
    if (state.status == DeveloperStatus.loaded) return;
    
    emit(state.copyWith(status: DeveloperStatus.loading));
    
    try {
      final developerInfo = await repository.getDeveloperInfo();
      emit(state.copyWith(
        status: DeveloperStatus.loaded,
        developerInfo: developerInfo,
      ));
    } catch (e) {
      developer.log(
        'Ошибка при загрузке информации о разработчике: $e',
        name: 'DeveloperBloc',
        error: e,
      );
      emit(state.copyWith(
        status: DeveloperStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  
  Future<void> _onRefreshDeveloperInfo(
    RefreshDeveloperInfo event,
    Emitter<DeveloperState> emit,
  ) async {
    emit(state.copyWith(status: DeveloperStatus.loading));
    
    try {
      final developerInfo = await repository.getDeveloperInfo();
      emit(state.copyWith(
        status: DeveloperStatus.loaded,
        developerInfo: developerInfo,
      ));
    } catch (e) {
      developer.log(
        'Ошибка при обновлении информации о разработчике: $e',
        name: 'DeveloperBloc',
        error: e,
      );
      emit(state.copyWith(
        status: DeveloperStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
} 