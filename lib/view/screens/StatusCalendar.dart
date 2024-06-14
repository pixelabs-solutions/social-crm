import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/TimeSelectionScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class StatusCalendarScreen extends StatefulWidget {
  const StatusCalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatusCalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<StatusCalendarScreen> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                      'Bulletin Board',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
        
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding:  EdgeInsets.only(left:  12.0.w, right: 8),
                child: Container(
                  height: 300.h, // 70% of screen height
        
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Column(
                    children: [
        
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
        
        
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(left: 12.0.w, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 37.h, // Adjust height as needed
                            decoration: BoxDecoration(
                              color: AppColors.orangeButtonColor,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/smalImgIcon.svg", width: 15.w ,height: 15.h,),
                                SizedBox(width: 5.w),
                                Text(
                                  'Status Upload',
                                  style: AppConstantsTextStyle.heading2Style,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 37.h, // Adjust height as needed
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/viewIcon.svg", width: 15.w ,height: 15.h,),
                                SizedBox(width: 5.w),
                                Text(
                                  'Add Customer',
                                  style: AppConstantsTextStyle.paragraph2Style,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor, // Example color
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This month',
                                style: TextStyle(color: Colors.white, fontSize: 18.0),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                '174',
                                style:AppConstantsTextStyle.heading1StyleOrange,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'Status Uplaod',
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
        
            ],
          ),
        ),
      ),
    );
  }
}
