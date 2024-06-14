// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {super.key,
      required this.fieldBackgroundColor,
      required this.options,
      required this.selectedItem,
      required this.onOptionSelected,
      required this.controller,
      this.hint});

  final MultiSelectController controller;
  final Color fieldBackgroundColor;
  final List<ValueItem> options;
  final String? hint;
  final void Function(List<ValueItem>) onOptionSelected;
  final List<ValueItem> selectedItem;

  @override
  Widget build(BuildContext context) {
    List<ValueItem> displayItems =
        selectedItem.isNotEmpty ? selectedItem : [options.first];

    return MultiSelectDropDown<dynamic>(
      showChipInSingleSelectMode: false,
      focusedBorderColor: Colors.transparent,
      hint: hint ?? '',
      borderColor: Colors.transparent,
      fieldBackgroundColor: fieldBackgroundColor,
      controller: controller,
      onOptionSelected: onOptionSelected,
      options: options,
      selectionType: SelectionType.single,
      searchEnabled: false,
      selectedOptions: displayItems,
      optionTextStyle: AppConstantsTextStyle.kTextFieldTextStyle,
      selectedOptionIcon:
          const Icon(Icons.check_circle, color: AppColors.scaffoldColor),
      singleSelectItemStyle: AppConstantsTextStyle.kTextFieldTextStyle,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      clearIcon: null,
    );
  }
}
