import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';

class AppConstantsTextStyle {
  static TextStyle kNormalWhiteTextStyle = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 14.sp,
    fontFamily: 'Rubik One',
    fontWeight: FontWeight.normal,
  );
  static TextStyle kSmallButtonBoldWhiteTextStyle = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 12.sp,
    fontFamily: 'Rubik One',
    fontWeight: FontWeight.w400,
  );
  static TextStyle kDefaultappTextStyle = TextStyle(
    color: AppColors.defaultTextColor,
    fontSize: 14.sp,
    fontFamily: 'Noto Sans Hebrew',
    fontWeight: FontWeight.normal,
  );
  static TextStyle heading1Style = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontFamily: 'Rubik One',
  );

  static TextStyle heading2Style = const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontFamily: 'Noto Sans',
      fontWeight: FontWeight.bold);

  static TextStyle paragraph1Style = const TextStyle(
      fontSize: 18,
      color: AppColors.orangeButtonColor,
      fontFamily: 'Noto Sans',
      fontWeight: FontWeight.bold);
  static TextStyle paragraph2Style = const TextStyle(
      fontSize: 16,
      color: AppColors.orangeButtonColor,
      fontFamily: 'Noto Sans',
      fontWeight: FontWeight.w500);
}
