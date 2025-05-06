import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name;
  final int level; // Уровень от 1 до 5
  final String category;
  
  const Skill({
    required this.name,
    required this.level,
    required this.category,
  });
  
  @override
  List<Object> get props => [name, level, category];
  
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] ?? '',
      level: json['level'] ?? 1,
      category: json['category'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'category': category,
    };
  }
} 