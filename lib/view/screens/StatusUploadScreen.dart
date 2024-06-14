import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import 'StatusCalendar.dart';
import 'TextStatusStep1.dart';
import 'imgUploadStep1.dart';
import 'videoStatusStep1.dart';

class StatusUploadScreen extends StatefulWidget {
  @override
  State<StatusUploadScreen> createState() => _StatusUploadScreenState();
}

class _StatusUploadScreenState extends State<StatusUploadScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: HomeAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 12.w, right: 12.w),
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

                    Center(
                      child: Text(
                        'Status Uplaod',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.w,),
              Padding(
                padding:  EdgeInsets.only(left: 14.0.w, right: 10.w, top: 10.h),
                child: Container(
                  height: 370.h,

                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),

                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Status Type", style: AppConstantsTextStyle.heading2Style,),
                      _buildStatusItem(
                        context,
                        'Text Status',
                        'assets/textIconLarge.svg',
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFFFF9D00).withOpacity(0.4),
                            Color(0xFFFFFFFF).withOpacity(0.38),
                          ],
                          stops: [0.033, 0.973],
                        ), onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (i)=>TextStatusStep1Screen())
                        );
                      },
                      ),
                      _buildStatusItem(
                        context,
                        'Image Status',
                        'assets/imgIconLarge.svg',
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFFFF9D00).withOpacity(0.4),
                            Color(0xFFFFFFFF).withOpacity(0.38),
                          ],
                          stops: [0.033, 0.973],
                        ), onTap: () {

                          Navigator.push(context,
                              MaterialPageRoute(builder: (i)=>ImageUploadStep1Screen())
                          );

                      },
                      ),
                      _buildStatusItem(
                        context,
                        'Video Status',
                        'assets/videoIconLarge.svg',
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,

                          colors: [
                            Color(0xFFFF9D00).withOpacity(0.4),
                            Color(0xFFFFFFFF).withOpacity(0.38),

                          ],
                          stops: [0.033, 0.973],
                        ), onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (i)=>VideoUploadStep1Screen())
                        );
                      },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: ConstantLargeButton(
                            text: "Next Step",
                            onPressed: (){
                                 Navigator.push(context,
                                    MaterialPageRoute(builder: (o)=>StatusCalendarScreen())
                                 );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context,
      String title,
      String iconPath, {
        required VoidCallback onTap,
    required Gradient gradient}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: onTap,

        child: Container(

          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: gradient,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 35.0.h,
                width: 30.0.w,
              ),
              SizedBox(width: 16.0),
              Text(
                  title,
                  style: AppConstantsTextStyle.heading2Style
              ),
            ],
          ),
        ),
      ),
    );
  }
}