import 'package:myport4lio/core/models/project.dart';
import 'package:myport4lio/core/repositories/base_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectsRepository extends BaseRepository {
  ProjectsRepository({required SupabaseClient client}) : super(client: client);
  
  Future<List<Project>> getProjects() async {
    return safeCall(
      call: () async {
        final response = await client
            .from('projects')
            .select()
            .order('created_at', ascending: false);
            
        return response.map((project) => Project.fromJson(project)).toList();
      },
    );
  }
  
  Future<Project> getProjectById(String id) async {
    return safeCall(
      call: () async {
        final response = await client
            .from('projects')
            .select()
            .eq('id', id)
            .single();
            
        return Project.fromJson(response);
      },
    );
  }
} 