import 'package:myport4lio/core/models/developer_info.dart';
import 'package:myport4lio/core/repositories/base_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeveloperRepository extends BaseRepository {
  DeveloperRepository({required SupabaseClient client}) : super(client: client);
  
  Future<DeveloperInfo> getDeveloperInfo() async {
    return safeCall(
      call: () async {
        final response = await client
            .from('developer_info')
            .select()
            .limit(1)
            .single();
            
        return DeveloperInfo.fromJson(response);
      },
    );
  }
} 