import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: AppFonts.montserrat,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.lightBackground),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.deepBlack,
      secondary: AppColors.white,
      tertiary: AppColors.violetDark,
      scrim: AppColors.greyLight,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.textPrimaryLight),
      displayMedium: TextStyle(color: AppColors.textPrimaryLight),
      displaySmall: TextStyle(color: AppColors.textPrimaryLight),
      headlineLarge: TextStyle(color: AppColors.textPrimaryLight),
      headlineMedium: TextStyle(color: AppColors.textPrimaryLight),
      headlineSmall: TextStyle(color: AppColors.textPrimaryLight),
      titleLarge: TextStyle(color: AppColors.textPrimaryLight),
      titleMedium: TextStyle(color: AppColors.textPrimaryLight),
      titleSmall: TextStyle(color: AppColors.textSecondaryLight),
      bodyLarge: TextStyle(color: AppColors.textPrimaryLight),
      bodyMedium: TextStyle(color: AppColors.textSecondaryLight),
      bodySmall: TextStyle(color: AppColors.textSecondaryLight),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconLight, size: 24),
    shadowColor: AppColors.shadowLight,
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: AppFonts.montserrat,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkBackground),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.white,
      secondary: AppColors.deepBlack,
      tertiary: AppColors.violetLight,
      scrim: AppColors.greyDark,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.textPrimaryDark),
      displayMedium: TextStyle(color: AppColors.textPrimaryDark),
      displaySmall: TextStyle(color: AppColors.textPrimaryDark),
      headlineLarge: TextStyle(color: AppColors.textPrimaryDark),
      headlineMedium: TextStyle(color: AppColors.textPrimaryDark),
      headlineSmall: TextStyle(color: AppColors.textPrimaryDark),
      titleLarge: TextStyle(color: AppColors.textPrimaryDark),
      titleMedium: TextStyle(color: AppColors.textPrimaryDark),
      titleSmall: TextStyle(color: AppColors.textSecondaryDark),
      bodyLarge: TextStyle(color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
      bodySmall: TextStyle(color: AppColors.textSecondaryDark),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconDark, size: 24),
    shadowColor: AppColors.shadowDark,
    useMaterial3: true,
  );
}
