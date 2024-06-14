import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/publishSuccesScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({Key? key}) : super(key: key);

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  DateTime _currentDate = DateTime.now();

  // Sample list of times
  List<String> times = [
    '10:00 ',
    '11:00 ',
    '12:00 ',
    '01:00 ',
    '02:00 ',
    '03:00 ',
    '04:00 ',
    '05:00 ',
    '06:00 ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Status timing',
                    style: AppConstantsTextStyle.heading1Style,
                  ),
                  // Optionally add arrows for month navigation here
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Padding(
              padding:  EdgeInsets.only(left: 12.0.w, right: 12.w),
              child: Container(
                height: 400.0.h, // Adjust height as needed
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 10.0),
                      Text(
                        "Choose a Time",
                        style: AppConstantsTextStyle.heading2Style,
                      ),
                      SizedBox(height: 10.0.h),
                      Container(
                        height: 70.0.h, // Adjust height as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 2.0,
                            colors: [
                              // #A3A3A3 in 32-bit hexadecimal (ARGB)
                              Color(0xFF097382),
                              Color(0xFFA3A3A3),// #097382 in 32-bit hexadecimal (ARGB)
                            ],
                            stops: [0.0, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 1.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10',
                              style: TextStyle(
                                fontSize: 36.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              ':',
                              style: TextStyle(
                                fontSize: 36.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '30',
                              style: TextStyle(
                                fontSize: 36.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      Text("Busy Times", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.0.h),

                      Column(

                        children: _buildTimeRows(),
                      ),
                      SizedBox(height: 20.0.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: ConstantLargeButton(
                          text: "Select an Hour -->",
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (i)=>PublishSuccess())
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeRows() {
    List<Widget> rows = [];

    for (int i = 0; i < times.length; i += 3) {
      List<Widget> rowChildren = [];

      for (int j = i; j < i + 3 && j < times.length; j++) {
        rowChildren.add(Expanded(child: _buildTimeContainer(j)));
      }

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowChildren,
          ),
        ),
      );
    }

    return rows;
  }

  Widget _buildTimeContainer(int index) {
    // Replace with your SVG assets or use a placeholder
    String svgAsset = 'assets/smalImgIcon.svg';

    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      width: 70.0.w, // Adjust width as needed
      height: 35.h, // Adjust height as needed
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor40Opacity,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            height: 16.0.h, // Adjust size as needed
            width: 16.0.w,
          ),
          SizedBox(width: 8.w,),
          Text(
            times[index],
            style: AppConstantsTextStyle.paragraph2Style
          ),
        ],
      ),
    );
  }
}
