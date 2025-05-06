import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myport4lio/core/constants/app_colors.dart';

abstract class AppTextStyles {
  // static const String fontFamily = 'Inter';
  
  // Заголовки
  static TextStyle h1 = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 46,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
  );
  
  static TextStyle h2 = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );
  
  static TextStyle h3 = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  // Подзаголовки
  static TextStyle subtitle = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  
  // Текст
  static TextStyle body = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle bodySecondary = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  // Меню и кнопки
  static TextStyle button = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );
  
  static TextStyle menu = GoogleFonts.inter(
    // fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.0,
    textBaseline: TextBaseline.alphabetic,
  );
} 