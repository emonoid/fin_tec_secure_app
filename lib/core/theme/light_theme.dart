import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    toolbarHeight: 52,
    titleTextStyle: TextStyle(
      color: AppColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    color: AppColors.whiteColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: AppColors.blackColor,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.blackColor,
    ),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.blackColor,
      systemNavigationBarDividerColor: AppColors.blackColor,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.blackColor,
    size: 24,
  ),
  fontFamily: 'Poppins',
  primaryColor: AppColors.primaryColor,
  secondaryHeaderColor: AppColors.primaryAccentColor,
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor: AppColors.lightGrey,
  brightness: Brightness.light,
  hintColor: const Color(0xFF808080),
  cardColor: AppColors.whiteColor,
  cardTheme: CardThemeData(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.zero,
    color: AppColors.whiteColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
    ),
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
      borderSide: const BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    fillColor: AppColors.whiteColor,
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
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.blackColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      color: AppColors.blackColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: AppColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: AppColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.blackColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: AppColors.blackColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: AppColors.blackColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: AppColors.blackColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: AppColors.blackColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
        color: AppColors.blackColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.0),
    labelMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.0),
    labelLarge: TextStyle(
        color: AppColors.blackColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.0),
  ),
  colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryAccentColor,
      background: AppColors.lightGrey,
      error: AppColors.redColor),
);
