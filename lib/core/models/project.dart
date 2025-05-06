import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String imageUrl;
  final String? category;
  final List<String> technologies;
  final String detailText;
  final String? appUrl;
  final String? githubUrl;
  
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
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
    imageUrl, 
    category, 
    technologies, 
    detailText, 
    appUrl, 
    githubUrl
  ];
  
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      detailText: json['detail_text'] ?? '',
      appUrl: json['app_url'],
      githubUrl: json['github_url'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'category': category,
      'technologies': technologies,
      'detail_text': detailText,
      'app_url': appUrl,
      'github_url': githubUrl,
    };
  }
} 