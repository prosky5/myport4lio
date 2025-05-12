import 'package:flutter/material.dart';

abstract class AppColors {
  // Основные цвета
  static const Color beige = Color(0xFFE8BE88);      // Бежевый фон
  static const Color white = Color(0xFFFFFFFF);      // Белый для карточек/фона
  static const Color blue = Color(0xFF223A5E);       // Глубокий синий (основной акцент)
  static const Color gold = Color(0xFFD4AF37);       // Золото (акцент, детали)
  static const Color gray = Color(0xFFB0B0B0);       // Светлый серый для второстепенного
  static const Color darkGray = Color(0xFF6E6E6E);   // Тёмно-серый для текста

  // Акцентные цвета
  static const Color accent = blue;
  static const Color accent2 = gold;

  // Фоновые цвета
  static const Color cardBackground = beige;
  static const Color background = blue;

  // Текстовые цвета
  static const Color textPrimary = blue;
  static const Color textSecondary = darkGray;

  // Градиенты для карточек и блоков
  static const LinearGradient cardGradient = LinearGradient(
    colors: [white, beige],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGoldGradient = LinearGradient(
    colors: [blue, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueWhiteGradient = LinearGradient(
    colors: [blue, white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient beigeGoldGradient = LinearGradient(
    colors: [beige, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}