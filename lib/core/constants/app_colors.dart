import 'package:flutter/material.dart';

abstract class AppColors {
  // Основные цвета темы
  static const Color darkBlue = Color(0xFF0E1117);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color gray = Color(0xFFAAAAAA);
  
  // Акцентные цвета
  static const Color accent = Color(0xFF2A71F2);
  static const Color secondary = Color(0xFF6A6AF5);
  
  // Фоновые цвета
  static const Color background = darkBlue;
  static const Color cardBackground = Color(0xFF1A1E26);
  
  // Текстовые цвета
  static const Color textPrimary = white;
  static const Color textSecondary = Color(0xFFCCCCCC);
} 