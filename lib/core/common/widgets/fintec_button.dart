import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'fintec_text.dart';

class FinTecButton extends StatelessWidget {
  const FinTecButton({
    required this.onTap,
    this.borderRadius,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.buttonWidth,
    this.fontSize,
    this.fontWeight,
    required this.buttonText,
    this.buttonHeight,
    this.gradient,
    required this.isLoading,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.textDecoration,
    this.boxShadow,
    required this.showIcon,
    Key? key,
  }) : super(key: key);
  final VoidCallback? onTap;
  final Color? buttonColor;
  final double? borderRadius;
  final Color? textColor;
  final String buttonText;
  final Color? borderColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final bool isLoading;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final TextDecoration? textDecoration;
  final List<BoxShadow>? boxShadow;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 50,
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,

        // gradient: onTap != null ? gradient : null,
        color: onTap != null
            ? buttonColor ?? AppColors.greenColor
            : Colors.grey.withOpacity(0.5),
        border: Border.all(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: !isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 10,
                          fit: FlexFit.loose,
                          child: Align(
                            alignment: Alignment.center,
                            child: FinTecTextWidget(
                              text: buttonText,
                              color: textColor,
                              fontSize: fontSize ?? 16.0,
                              fontWeight: fontWeight ?? FontWeight.w400,
                              textDecoration: textDecoration,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: icon != null
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    icon,
                                    size: iconSize ?? 16,
                                    color: iconColor ?? AppColors.whiteColor,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
