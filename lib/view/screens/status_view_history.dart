// views/status_history_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

class StatusHistoryView extends StatelessWidget {
  const StatusHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding:  EdgeInsets.only(left: 8.w, right: 8.w),
        child: Column(
          children: [
           
            Padding(
              padding:  EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
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
                  Center(
                    child: Text(
                      'Status History (24 Hours)',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.all(12.0),
              padding:  EdgeInsets.only(
                  top: 12.0.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10, // Replace with your dynamic item count
                itemBuilder: (context, index) {
                  return  Column(
                    children: [
                      const StatusRow(
                        iconPath: 'assets/viewIcon.svg',
                        views: '4,500 ',
                        time: '08:00',
                        rightIconPath: 'assets/e6.png',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:20.w),
                        child: const Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String iconPath;
  final String views;
  final String time;
  final String rightIconPath;

  const StatusRow(
      {super.key,
      required this.iconPath,
      required this.views,
      required this.time,
      required this.rightIconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(left: 20.0.h, right: 20.h,top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 22.h,
              ),
              SizedBox(width: 12.w),
              Text(
                views,
                style: AppConstantsTextStyle.heading2Style,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                time,
                style:  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp),
              ),
               SizedBox(width: 12.w),
              Image.asset(
                rightIconPath,
                height: 28.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
