import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';

class ConstantLargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ConstantLargeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orangeButtonColor),
        child: Text(
          text,
          style: AppConstantsTextStyle.kSmallButtonBoldWhiteTextStyle,
        ),
      ),
    );
  }
}
