import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/app_space.dart';
import 'fintec_button.dart';
import 'fintec_text.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/animations/no-internet.json',
              fit: BoxFit.fill,
            ),
          ),
          AppSpace.spaceH10,
          const FinTecTextWidget(
            text: "No internet!",
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
            fontSize: 20,
          ),
          AppSpace.spaceH10,
          FinTecButton(
            onTap: () {},
            buttonHeight: 40,
            buttonWidth: 110,
            buttonText: "Try Again",
            isLoading: false,
            borderColor: AppColors.blackColor,
            buttonColor: AppColors.whiteColor,
            showIcon: false,
          ),
        ],
      ),
    );
  }
}
