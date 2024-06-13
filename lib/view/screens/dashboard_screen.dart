import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_bottomNavigationBar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding:  EdgeInsets.all(14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RoundedContainer(
                    color: AppColors.orangeButtonColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/faCalendar.svg",
                          height: 33.h,
                          width: 33.w,
                        ),
                         SizedBox(height: 5.h),
                         Text(
                          '45',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Ads Pending',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                 SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: RoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/userVector.svg",
                          height: 32.h,
                          width: 32.w,
                        ),
                         SizedBox(
                          height: 3.h,
                        ),
                         Text(
                          '500',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Customers',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/backImg.jpeg",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.275,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      padding:  EdgeInsets.all(8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Highest number of viewers",
                            style: AppConstantsTextStyle.paragraph1Style,
                          ),
                           SizedBox(
                            height: 10.h,
                          ),
                           Text(
                            '45,564',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                           SizedBox(height: 14.h),
                          GestureDetector(
                            onTap: () {
                              // Handle button tap
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 22.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.orangeButtonColor,
                                    width: 2.w),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.transparent,
                              ),
                              child:  Text(
                                'Post it to me as Status',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -35.h,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/faEye.svg', // Replace with your SVG icon path
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
              ],
            ),
             SizedBox(height: 14.h),
            RoundedContainer(
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('The Upcoming Status',
                          style: AppConstantsTextStyle.heading2Style),
                       SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        '16:45  24/05/ 2024',
                        style: AppConstantsTextStyle.paragraph2Style,
                      ),
                    ],
                  ),
                   SizedBox(
                    width: 13.w,
                  ),
                  SvgPicture.asset("assets/faMobile.svg",height: 40.h,width: 35.w,),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class RoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const RoundedContainer({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
