import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_space.dart';
import 'fintec_text.dart';
import 'sneak_bar.dart';

class FinTecDatePicker extends StatelessWidget {
  const FinTecDatePicker({
    super.key,
    required this.onTap,
    required this.selectedDateTime,
  });

  final Function(DateTime) onTap;
  final DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2023),
          lastDate: DateTime(2050),
        );
        if (pickedDate != null) {
          onTap(pickedDate);
        } else {
          if (context.mounted) {
            FinTecSneakBar.customSnackBar(
              context: context,
              snackText: "Please select data.",
            );
          }
        }
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.scaffoldBackGroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FinTecTextWidget(
              text: DateFormat('dd-MMM-yyy').format(selectedDateTime),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppSpace.spaceW6,
            const Icon(Icons.calendar_month, size: 22),
          ],
        ),
      ),
    );
  }
}
