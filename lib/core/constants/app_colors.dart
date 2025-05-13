import 'package:flutter/material.dart';

abstract class AppColors {
  // Основные цвета
  // static const Color beige = Color(0xFF836E61);      // Бежевый фон
  static const Color white = Color(0xFFFFFFFF);      // Белый для карточек/фона
  static const Color purp = Color(0xFF25274D);       // Золото (акцент, детали)
  static const Color purp2 = Color(0xFF464866);       // Золото (акцент, детали)
  static const Color blue = Color(0xFF2E9CCA);       // Глубокий синий (основной акцент)
  static const Color blue2 = Color(0xFF29648A);       // Глубокий синий (основной акцент)
  static const Color gray = Color(0xFFAAABB8);       // Светлый серый для второстепенного
  // static const Color darkGray = Color(0xFF6E6E6E);   // Тёмно-серый для текста

  // Акцентные цвета
  static const Color accent = blue;
  static const Color accent2 = blue2;

  // Фоновые цвета
  static const Color cardBackground = purp2;
  static const Color background = purp;

  // Текстовые цвета
  static const Color textPrimary = white;
  static const Color textSecondary = gray;

  // Градиенты для карточек и блоков
  static const LinearGradient cardGradient = LinearGradient(
    colors: [purp, purp2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpTransGradient = LinearGradient(
    colors: [purp, Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient blueGrayGradient = LinearGradient(
    colors: [blue, gray],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bluePurpGradient = LinearGradient(
    colors: [blue2, purp2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}