import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';

class ConstantSmallButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const ConstantSmallButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 150.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : AppColors.primaryColor2,
        ),
        child: Text(
          text,
          style: AppConstantsTextStyle.kSmallButtonBoldWhiteTextStyle,
        ),
      ),
    );
  }
}

class CustomSmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final String icon;

  const CustomSmallButton({
    super.key,
    required this.text,
    required this.buttonColor,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 150.w,
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20.h,
                  child: Image.asset(
                    icon,
                    height: 160.h,
                  ),
                ),
                // SizedBox(
                //   width: 5.w,
                //),
                Text(
                  text,
                  style: AppConstantsTextStyle.kSmallButtonBoldWhiteTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
