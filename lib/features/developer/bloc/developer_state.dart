import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/developer_info.dart';

enum DeveloperStatus { initial, loading, loaded, error }

class DeveloperState extends Equatable {
  final DeveloperStatus status;
  final DeveloperInfo? developerInfo;
  final String? errorMessage;
  
  const DeveloperState({
    this.status = DeveloperStatus.initial,
    this.developerInfo,
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [status, developerInfo, errorMessage];
  
  DeveloperState copyWith({
    DeveloperStatus? status,
    DeveloperInfo? developerInfo,
    String? errorMessage,
  }) {
    return DeveloperState(
      status: status ?? this.status,
      developerInfo: developerInfo ?? this.developerInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 