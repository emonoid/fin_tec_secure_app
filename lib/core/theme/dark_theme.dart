import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppins',
  appBarTheme: const AppBarTheme(
    toolbarHeight: 52,
    titleTextStyle: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: AppColors.darkColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.blackColor,
    ),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.darkColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.whiteColor,
      systemNavigationBarDividerColor: AppColors.whiteColor,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.whiteColor,
    size: 24,
  ),
  primaryColor: AppColors.primaryColor,
  secondaryHeaderColor: AppColors.primaryAccentColor,
  disabledColor: const Color(0xffa2a7ad),
  scaffoldBackgroundColor: AppColors.darkGrey,
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: AppColors.darkColor,
  cardTheme: CardThemeData(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: AppColors.darkColor,
    margin: EdgeInsets.zero,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkGrey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkGrey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkGrey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.redColor),
      borderRadius: BorderRadius.circular(8.0),
    ),
    fillColor: AppColors.blackColor,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    suffixIconColor: AppColors.darkGrey,
    prefixIconColor: AppColors.darkGrey,
    hintStyle: const TextStyle(
      color: AppColors.darkGrey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: const TextStyle(
      color: AppColors.whiteColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    titleLarge: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.0),
    labelMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.0),
    labelLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.0),
  ),
  colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryAccentColor,
      background: AppColors.darkColor,
      error: AppColors.redColor),
);
