import 'dart:developer' as developer;
import 'package:myport4lio/core/repositories/developer_repository.dart';
import 'package:myport4lio/core/repositories/projects_repository.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();
  
  late final DeveloperRepository developerRepository;
  late final ProjectsRepository projectsRepository;
  late final SupabaseClient supabaseClient;
  
  void init(SupabaseClient client) {
    supabaseClient = client;
    
    // Repositories
    developerRepository = DeveloperRepository(client: supabaseClient);
    projectsRepository = ProjectsRepository(client: supabaseClient);
    
    // Проверка соединения с Supabase
    checkSupabaseConnection();
  }
  
  // Проверяет соединение с Supabase и логирует результат
  Future<bool> checkSupabaseConnection() async {
    try {
      // Делаем простой запрос для проверки соединения
      await supabaseClient.from('developer_info').select('count').limit(1);
      developer.log('Соединение с Supabase установлено успешно', name: 'Supabase');
      return true;
    } catch (e) {
      developer.log(
        'Ошибка соединения с Supabase: $e',
        name: 'Supabase',
        error: e,
      );
      return false;
    }
  }
  
  // BLoCs
  DeveloperBloc getDeveloperBloc() {
    return DeveloperBloc(repository: developerRepository);
  }
  
  ProjectsBloc getProjectsBloc() {
    return ProjectsBloc(repository: projectsRepository);
  }
  
  ProjectDetailsBloc getProjectDetailsBloc() {
    return ProjectDetailsBloc(repository: projectsRepository);
  }
} 