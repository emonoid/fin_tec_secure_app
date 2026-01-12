import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'fintec_text.dart';

class FinTecDropDownBtn extends StatelessWidget {
  const FinTecDropDownBtn({
    Key? key,
    this.value,
    this.child,
    required this.hint,
    this.dropdownWidth,
    this.color,
    this.fontSize,
    this.iconColor,
    this.validator,
    required this.items,
    this.selectedValue,
    required this.onChanged,
  }) : super(key: key);
  final dynamic value;
  final String hint;
  final double? dropdownWidth;
  final Color? color;
  final Color? iconColor;
  final double? fontSize;
  final String? Function(dynamic)? validator;
  final Widget? child;

  final List<CustomDropdownItem> items;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackGroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: DropdownButton(
        isExpanded: true,
        alignment: Alignment.center,
        value: selectedValue,

        // isDense: true,
        borderRadius: BorderRadius.circular(15),
        underline: const SizedBox(),
        hint: FinTecTextWidget(
          text: hint,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.primaryTextColor,
          maxLines: 1,
        ),

        style: TextStyle(fontSize: fontSize ?? 18),

        items: items.map((CustomDropdownItem item) {
          return DropdownMenuItem(
            value: item.value,
            child: FinTecTextWidget(
              text: item.displayText,
              fontSize: fontSize ?? 15,
              color: color ?? AppColors.primaryTextColor,
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // validator: validator,
      ),
    );
  }
}

class CustomDropdownItem {
  final dynamic value;
  final String displayText;

  CustomDropdownItem({required this.value, required this.displayText});
}
