import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/developer_info.dart';

sealed class DeveloperState extends Equatable {
  const DeveloperState();

  @override
  List<Object?> get props => [];

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(DeveloperInfo developerInfo) loaded,
    required T Function(String message) error,
  }) {
    return switch (this) {
      DeveloperInitial() => initial(),
      DeveloperLoading() => loading(),
      DeveloperLoaded(developerInfo: final info) => loaded(info),
      DeveloperError(message: final msg) => error(msg),
    };
  }
}

class DeveloperInitial extends DeveloperState {
  const DeveloperInitial();
}

class DeveloperLoading extends DeveloperState {
  const DeveloperLoading();
}

class DeveloperLoaded extends DeveloperState {
  final DeveloperInfo developerInfo;

  const DeveloperLoaded(this.developerInfo);

  @override
  List<Object?> get props => [developerInfo];
}

class DeveloperError extends DeveloperState {
  final String message;

  const DeveloperError(this.message);

  @override
  List<Object?> get props => [message];
} 