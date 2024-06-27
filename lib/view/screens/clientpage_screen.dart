// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

import 'editing_customerdetails_screen.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

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
                      'פרטי לקוח: אליהו מלכה',
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
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.h,),
                        _customRow("דוא\"ל", "פעיל"),
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
                              child: const Center(child: Text("כבוי")),
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
                          height: 5.h,
                        ),
                        _customIconRow("assets/editIcon.svg", "טלפון", onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (o)=>EditingCustomerDetails())
                          );
                        }),
                        showText("03114858538"),
                        SizedBox(
                          height: 5.h,
                        ),
                        _customIconRow("assets/deleteIcon.svg", "מקצוע",
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (o)=>EditingCustomerDetails())
                              );
                            }),
                        showText("איפור"),
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
                                "היסטוריית פרסומים",
                                style:
                                AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        statusRow("14,500", "24/06/15", "סטטוס וידאו",
                            "assets/vedioStatusIcon.svg"),
                        statusRow(
                            "14,500", "24/06/15", "סטטוס טקסט", "assets/A.svg"),
                        statusRow("14,500", "24/06/15", "סטטוס תמונה",
                            "assets/photoStatusIcon.svg"),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget statusRow(String views, String date, String title, String icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/eyeIcon.svg",
                    width: 12.w,
                    height: 12.h,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    views,
                    style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 60.w,
              child: Text(
                date,
                style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    title,
                    style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SvgPicture.asset(
                    icon,
                    width: 12.w,
                    height: 12.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: const Divider(
            color: Colors.white,
          ),
        ),
      ],
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

  Widget _customIconRow(String icon, String text,{ required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h),
            child: Text(
              text,
              style: AppConstantsTextStyle.kNormalWhiteTextStyle,
            ),
          )
        ],
      ),
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
