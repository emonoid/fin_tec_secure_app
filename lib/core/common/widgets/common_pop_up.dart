import '/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'fintec_button.dart';
import 'fintec_text.dart';

void commonPopUp({
  required BuildContext context,
  String? title,
  titleColor,
  titleFontSize,
  String? subtitle,
  subTitleColor,
  subTitleFontSize,
  primaryActionButtonText,
  secondaryActionButtonText,
  primaryActionButtonColor,
  primaryActionButtonTextColor,
  secondaryActionButtonColor,
  secondaryActionButtonTextColor,
  actionButtonCount = 1,
  image,
  buttonGradient,
  imageHeight,
  imageWidth,
  iconColor,
  onPrimaryActionButtonTap,
  onSecondaryActionButtonTap,
}) {
  showGeneralDialog(
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: AlertDialog(
            backgroundColor: AppColors.whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            titlePadding: const EdgeInsets.only(left: 10.0, right: 5, top: 5),
            contentPadding: const EdgeInsets.only(left: 10.0, right: 10),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.all(10.0),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image != null
                        ? Image.asset(
                            image,
                            height: imageHeight,
                            width: imageWidth,
                            color: iconColor,
                          )
                        : const SizedBox(),
                    if (image != null) const SizedBox(height: 5),
                    title != ''
                        ? FinTecTextWidget(
                            text: title!,
                            maxLines: 1,
                            color:
                                titleColor ??
                                AppColors.darkColor.withOpacity(0.7),
                            fontSize: titleFontSize ?? 18.0,
                            fontWeight: FontWeight.bold,
                          )
                        : const SizedBox(),
                    if (subtitle != null) const SizedBox(height: 5),
                    if (subtitle != null)
                      FinTecTextWidget(
                        text: subtitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        color:
                            subTitleColor ??
                            AppColors.darkColor.withOpacity(0.6),
                        fontSize: subTitleFontSize ?? 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              actionButtonCount == 1
                  ? SizedBox(
                      height: 45,
                      child: FinTecButton(
                        buttonText: primaryActionButtonText,
                        fontSize: 18,
                        onTap: onPrimaryActionButtonTap,
                        gradient: buttonGradient,
                        borderRadius: 10,
                        borderColor: primaryActionButtonColor ?? Colors.green,
                        buttonColor: primaryActionButtonColor ?? Colors.green,
                        textColor: primaryActionButtonTextColor ?? Colors.white,
                        isLoading: false,
                        showIcon: false,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: FinTecButton(
                              buttonText: primaryActionButtonText,
                              fontSize: 18,
                              onTap: onPrimaryActionButtonTap,
                              borderRadius: 10,
                              borderColor:
                                  primaryActionButtonColor ?? Colors.green,
                              buttonColor:
                                  primaryActionButtonColor ?? Colors.green,
                              textColor:
                                  primaryActionButtonTextColor ?? Colors.white,
                              isLoading: false,
                              showIcon: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.00),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: FinTecButton(
                              buttonText: secondaryActionButtonText,
                              fontSize: 18,
                              onTap: onSecondaryActionButtonTap,
                              borderRadius: 10,
                              borderColor:
                                  secondaryActionButtonColor ?? Colors.red,
                              buttonColor:
                                  secondaryActionButtonColor ?? Colors.red,
                              textColor:
                                  secondaryActionButtonTextColor ??
                                  Colors.white,
                              isLoading: false,
                              showIcon: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.00),
                      ],
                    ),
            ],
          ),
        ),
      );
    },
  );
}
