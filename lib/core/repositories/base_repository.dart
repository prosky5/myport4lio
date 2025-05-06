import 'dart:developer' as developer;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myport4lio/core/exceptions/app_exception.dart';

abstract class BaseRepository {
  final SupabaseClient client;
  
  BaseRepository({required this.client});
  
  Future<T> safeCall<T>({
    required Future<T> Function() call,
  }) async {
    try {
      return await call();
    } on PostgrestException catch (e) {
      developer.log(
        'Ошибка Supabase Postgrest: ${e.message}',
        name: 'SupabaseError',
        error: e,
      );
      throw ServerException(
        message: e.message,
        code: e.code,
      );
    } on AuthException catch (e) {
      developer.log(
        'Ошибка Supabase Auth: ${e.message}',
        name: 'SupabaseError',
        error: e,
      );
      throw ServerException(
        message: e.message,
        code: e.statusCode,
      );
    } catch (e) {
      developer.log(
        'Непредвиденная ошибка при запросе к Supabase: $e',
        name: 'SupabaseError',
        error: e,
      );
      throw ServerException(
        message: e.toString(),
      );
    }
  }
} 