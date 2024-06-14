import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/TimeSelectionScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentDate = DateTime.now();

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
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
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

                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding:  EdgeInsets.only(left:  12.0.w, right: 8),
              child: Container(
                height: 400.h, // 70% of screen height

                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Text("Choose a Day", style: AppConstantsTextStyle.heading2Style,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 16.w),
                      child: CalendarCarousel<Event>(
                        onDayPressed: (DateTime date, List<Event> events) {
                          setState(() {
                            _currentDate = date;
                          });
                        },
                        weekendTextStyle: TextStyle(color: Colors.white),
                        thisMonthDayBorderColor: Colors.grey,
                        headerTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                        selectedDateTime: _currentDate,
                        daysTextStyle: TextStyle(color: Colors.white),
                        weekdayTextStyle: TextStyle(color: Colors.white),
                        weekFormat: false,
                        height: 275.h,
                        selectedDayButtonColor: Colors.white,
                        selectedDayTextStyle: TextStyle(color: AppColors.primaryColor),
                        todayButtonColor: Colors.transparent,
                        todayTextStyle: TextStyle(color: Colors.white),
                        locale: 'en',
                        headerMargin: EdgeInsets.symmetric(vertical: 10.0.h),
                        prevDaysTextStyle: TextStyle(color: Colors.white), // Previous month arrow color
                        nextDaysTextStyle: TextStyle(color: Colors.white),
                        iconColor: AppColors.orangeButtonColor,// Next month arrow color
                      ),
                    ),
                    SizedBox(height: 20.h,),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: ConstantLargeButton(text: "Select an Hour -->",
                          onPressed:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (i)=>TimeSelection())
                            );
                          }
                      ),
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
}
