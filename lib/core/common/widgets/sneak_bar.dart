import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'fintec_text.dart';

class FinTecSneakBar {
  static void customSnackBar({
    required context,
    required String snackText,
    SnackBarBehavior? snackBehavior,
    SnackBarAction? snackBarAction,
    double? snackTextSize,
    Color? snackTextColor,
    int? snackDuration,
    Color? snackBackgroundColor,
  }) {
    final snack = SnackBar(
      backgroundColor: snackBackgroundColor ?? AppColors.blackColor,
      behavior: snackBehavior ?? SnackBarBehavior.fixed,
      elevation: 0,
      action: snackBarAction,
      content: FinTecTextWidget(
        color: snackTextColor ?? AppColors.whiteColor,
        fontSize: snackTextSize ?? 14,
        maxLines: 4,
        text: snackText,
      ),
      duration: Duration(seconds: snackDuration ?? 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
