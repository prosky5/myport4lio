import 'package:equatable/equatable.dart';
import 'package:myport4lio/core/models/skill.dart';

class DeveloperInfo extends Equatable {
  final String name;
  final String title;
  final String location;
  final String avatarUrl;
  final String about;
  final List<Skill> skills;
  final List<String> softSkills;
  final Map<String, String> contacts;
  final String resumeUrl;
  
  const DeveloperInfo({
    required this.name,
    required this.title,
    required this.location,
    required this.avatarUrl,
    required this.about,
    required this.skills,
    required this.softSkills,
    required this.contacts,
    required this.resumeUrl,
  });
  
  @override
  List<Object> get props => [
    name, 
    title, 
    location, 
    avatarUrl, 
    about, 
    skills, 
    softSkills, 
    contacts, 
    resumeUrl
  ];
  
  factory DeveloperInfo.fromJson(Map<String, dynamic> json) {
    return DeveloperInfo(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      about: json['about'] ?? '',
      skills: (json['skills'] as List?)
          ?.map((skill) => Skill.fromJson(skill))
          .toList() ?? [],
      softSkills: List<String>.from(json['soft_skills'] ?? []),
      contacts: Map<String, String>.from(json['contacts'] ?? {}),
      resumeUrl: json['resume_url'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'location': location,
      'avatar_url': avatarUrl,
      'about': about,
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'soft_skills': softSkills,
      'contacts': contacts,
      'resume_url': resumeUrl,
    };
  }
} 