// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class DailyPostingSChedule extends StatelessWidget {
  const DailyPostingSChedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Center(
                    child: Text(
                      'Editing status details',
                      style: AppConstantsTextStyle.heading2Style,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.only(top: 12.0.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.arrow_back_ios_outlined,
                              color: AppColors.orangeButtonColor),
                          Column(
                            children: [
                              labelText("06/15/2024"),
                              showText("08:10")
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined,
                              color: AppColors.orangeButtonColor),
                        ],
                      ),
                       SizedBox(
                        height: 5.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 5.h,
                      ),
                      _customRow("Status type"),
                      SizedBox(
                        height: 8.h,
                      ),
                      labelText("Client Name"),
                      showText("Eliyahu Malka"),
                      SizedBox(
                        height: 5.h,
                      ),
                      labelText("Phone"),
                      showText("03114858538"),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          "preview",
                          style:
                              AppConstantsTextStyle.kNormalOrangeNotoTextStyle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          statusContainer("assets/mobileImage.png"),
                          statusContainer("assets/mobileImage.png"),
                          statusContainer("assets/mobileImage.png")
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      ConstantLargeButton(
                          text: "To change the posting times →", onPressed: () {})
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget statusContainer(String icon) {
    return Container(
      height: 90.h,
      width: 75.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.38),
              Color.fromRGBO(255, 157, 0, 0.40), // #FF9D00 with 40% opacity
            ],
            begin: Alignment.topLeft, // Adjust as needed
            end: Alignment.bottomRight, // Adjust as needed
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Image.asset(
        icon,
        width: 30.w,
        height: 30.h,
      ),
    );
  }

  Widget _customRow(String email) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/deleteIcon.svg",
          width: 18.w,
          height: 18.h,
          // ignore: deprecated_member_use
          color: AppColors.orangeButtonColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/photoStatusIcon.svg",
                width: 12.w,
                height: 12.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                email,
                style: AppConstantsTextStyle.kNormalWhiteTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget labelText(String text) {
    return Text(
      text,
      style: AppConstantsTextStyle.kNormalWhiteTextStyle,
    );
  }

  Widget showText(String text) {
    return Text(
      text,
      style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
    );
  }
}
