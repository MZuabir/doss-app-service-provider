import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/spacing.dart';


class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final String title;
  final String hint;
  final List<String> items;
  final bool enable;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({super.key,
    required this.selectedValue,
    required this.items,
    this.enable=true,
    required this.onChanged,
    required this.title, required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr(title),
          style: textTheme.bodyLarge,
        ),
        Spacing.y(1),
        Center(
          child: IgnorePointer(
            ignoring: !enable,
            child: Container(
              height: 50,
              width: double.infinity,
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3),
              color: AppColors.fieldClr,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  
                  isExpanded: true,
                  
                  hint: Text(hint,).tr(), // Not necessary for Option 1
                  value: selectedValue,
                  onChanged: onChanged,
                  items: items.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location,
                        style: textTheme.bodyLarge!.copyWith(color: Colors.black),
                      ).tr(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}