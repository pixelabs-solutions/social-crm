import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/customer.dart';
import '../../viewModel/CustomerList_vm.dart';
import 'editing_customerdetails_screen.dart';

class TextStatusScheduled extends StatefulWidget {
  const TextStatusScheduled({super.key});

  @override
  State<TextStatusScheduled> createState() => _TextStatusScheduledState();
}

class _TextStatusScheduledState extends State<TextStatusScheduled> {
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
                  SizedBox(width: 13.w),
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Text(
                          'Text Status Schedule',
                            style: AppConstantsTextStyle.heading2Style,
                          ),

                        ],
                      ),
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
                    SizedBox(height: 10.h),
                    _customIconRow("assets/deleteIcon.svg", "text: טקסט",
                        onTap: () {}),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "שם הלקוח:",
                              style:
                              AppConstantsTextStyle.heading1Style,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              // "${"widget.customer.phoneNumber"}",
                              "Junaid",
                              style:
                              AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "מספר טלפון:",
                              style:
                              AppConstantsTextStyle.heading1Style,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              // "${"widget.customer.phoneNumber"}",
                              "09876543",
                              style:
                              AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 200.h, width: 200.w,
                      decoration: BoxDecoration(
                        color: AppColors.statusContainerColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text("How R You ?"),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ConstantLargeButton(text: "Chnage",
                        onPressed: (){}
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(
      BuildContext context, CustomerViewModel viewModel, String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('אישור מחיקה'),
          content: const Text('האם אתה בטוח שברצונך למחוק את הלקוח?'),
          actions: <Widget>[
            TextButton(
              child: const Text('ביטול'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('מחק'),
              onPressed: () {
                viewModel.deleteCustomer(customerId).then((_) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Navigate back to previous screen
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _customIconRow(String icon, String text, {required VoidCallback onTap}) {
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
        ),
      ),
    );
  }
}
