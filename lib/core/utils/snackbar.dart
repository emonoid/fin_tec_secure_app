import 'package:flutter/material.dart';

void showSnackBar(
    {required context,
    required String snackText,
    SnackBarBehavior? snackBehavior,
    SnackBarAction? snackBarAction,
    double? snackTextSize,
    Color? snackTextColor,
    int? snackDuration,
    Color? snackBackgroundColor}) {
  final snack = SnackBar(
    backgroundColor: snackBackgroundColor ?? Colors.black54,
    behavior: snackBehavior ?? SnackBarBehavior.fixed,
    elevation: 0,
    action: snackBarAction,
    content: Text(
      snackText,
      style: TextStyle(color: snackTextColor ?? Colors.black),
    ),
    duration: Duration(seconds: snackDuration ?? 3),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snack);
}
