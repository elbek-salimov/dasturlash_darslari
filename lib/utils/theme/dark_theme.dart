import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';

class DarkTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.c232D3A,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.cDEE1E7),
    iconTheme: const IconThemeData(color: AppColors.c6F6B80, size: 24),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all((Colors.white)),
      trackColor: MaterialStateProperty.all((Colors.grey.shade300)),
    ),
    dividerColor: AppColors.cDEE1E7,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
    ),
    useMaterial3: true,
    cardColor: const Color(0xFF252525),
    shadowColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFB2C5FF),
      onPrimary: Color(0xFF002B73),
      primaryContainer: Color(0xFF0040A1),
      onPrimaryContainer: Color(0xFFDAE2FF),
      secondary: Color(0xFFFFBA20),
      onSecondary: Color(0xFF412D00),
      secondaryContainer: Color(0xFF5E4200),
      onSecondaryContainer: Color(0xFFFFDEA8),
      tertiary: Color(0xFFC5C0FF),
      onTertiary: Color(0xFF2400A2),
      tertiaryContainer: Color(0xFF3A20CB),
      onTertiaryContainer: Color(0xFFE3DFFF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF001B3D),
      onBackground: Color(0xFFD6E3FF),
      surface: Color(0xFF001B3D),
      onSurface: Color(0xFFD6E3FF),
      surfaceVariant: Color(0xFF45464F),
      onSurfaceVariant: Color(0xFFC5C6D0),
      outline: Color(0xFF8F909A),
      onInverseSurface: Color(0xFF001B3D),
      inverseSurface: Color(0xFFD6E3FF),
      inversePrimary: Color(0xFF0056D2),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFB2C5FF),
      outlineVariant: Color(0xFF45464F),
      scrim: Color(0xFF000000),
    ),
  );
}
