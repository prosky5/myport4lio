import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String imagesUrl;
  final String category;
  final List<String> technologies;
  final String detailText;
  final String? appUrl;
  final String? githubUrl;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imagesUrl,
    required this.category,
    required this.technologies,
    required this.detailText,
    this.appUrl,
    this.githubUrl,
  });
  
  @override
  List<Object?> get props => [
    id, 
    title, 
    description, 
    imagesUrl,
    category, 
    technologies, 
    detailText, 
    appUrl, 
    githubUrl,
  ];
  
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imagesUrl: json['imagesUrl'] ?? '',
      category: json['category'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      detailText: json['detailText'] ?? '',
      appUrl: json['appUrl'],
      githubUrl: json['githubUrl'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagesUrl': imagesUrl,
      'category': category,
      'technologies': technologies,
      'detailText': detailText,
      'appUrl': appUrl,
      'githubUrl': githubUrl,
    };
  }
} 