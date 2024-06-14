// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

class ClientUpdateStatus extends StatelessWidget {
  const ClientUpdateStatus({super.key});

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
                      'Client details: Eliyahu Malka',
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      _customRow("Email", "Active"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20.h,
                            width: 65.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.offstatusContainerColor,
                            ),
                            child: const Center(child: Text("off")),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "elyau.dms@gmail.com",
                              style: AppConstantsTextStyle
                                  .kNormalWhiteNotoTextStyle,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelText("Phone"),
                      showText("03114858538"),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelText("Profession"),
                      showText("make-up"),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        height: 35.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.kWhiteColor23pacity,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "The publication history",
                          style:
                              AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                        )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90.h,
                            width: 75.h,
                            decoration: BoxDecoration(
                                color: AppColors.orangeButtonColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: Column(
                                children: [
                                  Text(
                                    "Vedio",
                                    style: AppConstantsTextStyle
                                        .kNormalWhiteNotoSmallTextStyle,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  SvgPicture.asset(
                                    "assets/vedioStatusIcon.svg",
                                    width: 35.w,
                                    height: 35.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          statusContainer(
                              "Image", "assets/photoStatusIcon.svg"),
                          statusContainer("Text", "assets/A.svg")
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget statusContainer(String label, String icon) {
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          children: [
            Text(
              label,
              style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            SvgPicture.asset(
              icon,
              width: 30.w,
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customRow(String email, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 20.h,
          width: 65.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.statusContainerColor,
          ),
          child: Center(child: Text(status)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Text(
            email,
            style: AppConstantsTextStyle.kNormalWhiteTextStyle,
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
    return Padding(
      padding: EdgeInsets.only(top: 7.h),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
      ),
    );
  }
}
