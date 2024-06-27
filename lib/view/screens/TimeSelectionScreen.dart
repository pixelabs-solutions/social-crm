import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/publishSuccesScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:intl/intl.dart';

import '../../Model/Status.dart';

class TimeSelection extends StatefulWidget {
  final StatusData? statusData;
  const TimeSelection({Key? key, this.statusData}) : super(key: key);

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  DateTime _selectedTime = DateTime.now();

  // Sample list of times
  List<String> times = [
    '10:00',
    '11:00',
    '12:00',
    '01:00',
    '02:00',
    '03:00',
    '04:00',
    '05:00',
    '06:00',
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
                    'תזמון הסטטוס',
                    style: AppConstantsTextStyle.heading1Style,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Padding(
              padding: EdgeInsets.only(left: 12.0.w, right: 12.w),
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
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_selectedTime),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _selectedTime = DateTime(
                                _selectedTime.year,
                                _selectedTime.month,
                                _selectedTime.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              // Update selectedTime in StatusData
                              widget.statusData?.selectedTime = _selectedTime;
                            });
                          }
                        },
                        child: Container(
                          height: 70.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 2.0,
                              colors: [
                                Color(0xFF097382),
                                Color(0xFFA3A3A3),
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
                                DateFormat('HH').format(_selectedTime),
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
                                DateFormat('mm').format(_selectedTime),
                                style: TextStyle(
                                  fontSize: 36.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      Text("זמנים תפוסים", style: AppConstantsTextStyle.heading2Style),
                      SizedBox(height: 10.0.h),
                      Column(
                        children: _buildTimeRows(),
                      ),
                      SizedBox(height: 20.0.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: ConstantLargeButton(
                          text: "לפרסום הסטטוס ←",
                          onPressed: () {
                            print('Selected Text: ${widget.statusData?.text}');
                            print('Selected Background Color: ${widget.statusData?.backgroundColorHex}');
                            print('Selected Image Path: ${widget.statusData?.imagePaths}');
                            print('Selected Date: ${widget.statusData?.selectedDate}');
                            print('Selected Time: ${widget.statusData?.selectedTime}');
                            print('Selected Video: ${widget.statusData?.videoPath}');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (i) => PublishSuccess()),
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
    String svgAsset = 'assets/smalImgIcon.svg';

    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      width: 70.0.w,
      height: 35.h,
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
            height: 16.0.h,
            width: 16.0.w,
          ),
          SizedBox(width: 8.w),
          Text(
            times[index],
            style: AppConstantsTextStyle.paragraph2Style,
          ),
        ],
      ),
    );
  }
}
