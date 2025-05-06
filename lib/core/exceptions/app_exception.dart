import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final String? code;
  
  const AppException({
    required this.message,
    this.code,
  });
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => 'AppException: $message (code: $code)';
}

class ServerException extends AppException {
  const ServerException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class NetworkException extends AppException {
  const NetworkException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
} 