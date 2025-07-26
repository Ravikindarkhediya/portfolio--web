import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_portfolio/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    hintColor: AppColors.accentLight,
    // Used for accent color
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: const TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: const TextStyle(color: AppColors.textLight),
      labelLarge: const TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      secondary: AppColors.accentLight,
      onSecondary: Colors.white,
      background: AppColors.backgroundLight,
      onBackground: AppColors.textLight,
      surface: AppColors.cardLight,
      onSurface: AppColors.textLight,
      error: Colors.red,
      onError: Colors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.cardLight,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.cardLight),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    hintColor: AppColors.accentDark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(color: AppColors.textDark),
      labelLarge: TextStyle(color: Colors.black87), // For buttons
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: TextStyle(
        color: AppColors.textDark,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accentDark,
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      background: AppColors.backgroundDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.cardDark,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.cardDark),
  );
}
