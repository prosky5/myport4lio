import 'package:equatable/equatable.dart';

abstract class DeveloperEvent extends Equatable {
  const DeveloperEvent();
  
  @override
  List<Object> get props => [];
}

class LoadDeveloperInfo extends DeveloperEvent {
  const LoadDeveloperInfo();
}

class RefreshDeveloperInfo extends DeveloperEvent {
  const RefreshDeveloperInfo();
} 