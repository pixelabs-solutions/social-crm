import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

class StatusCalendar extends StatefulWidget {
  const StatusCalendar({super.key});

  @override
  State<StatusCalendar> createState() => _StatusCalendarState();
}

class _StatusCalendarState extends State<StatusCalendar> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: const HomeAppBar(),
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
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'bulletin board ',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 305.h, // 70% of screen height
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0.h, horizontal: 16.w),
                        child: CalendarCarousel<Event>(
                          onDayPressed: (DateTime date, List<Event> events) {
                            setState(() {
                              _currentDate = date;
                            });
                          },
                          weekendTextStyle:
                              const TextStyle(color: Colors.white),
                          thisMonthDayBorderColor: Colors.grey,
                          headerTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                          selectedDateTime: _currentDate,
                          daysTextStyle: const TextStyle(color: Colors.white),
                          weekdayTextStyle:
                              const TextStyle(color: Colors.white),
                          weekFormat: false,
                          height: 280.h,
                          selectedDayButtonColor: Colors.white,
                          selectedDayTextStyle:
                              const TextStyle(color: AppColors.primaryColor),
                          todayButtonColor: Colors.transparent,
                          todayTextStyle: const TextStyle(color: Colors.white),
                          locale: 'en',
                          headerMargin: EdgeInsets.symmetric(vertical: 10.0.h),
                          prevDaysTextStyle: const TextStyle(
                              color:
                                  Colors.white), // Previous month arrow color
                          nextDaysTextStyle:
                              const TextStyle(color: Colors.white),
                          iconColor: AppColors
                              .orangeButtonColor, // Next month arrow color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 5.w, right: 5.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        _iconCOntainer(
                            "Status upload ",
                            "assets/mobileIcon.svg",
                            AppColors.orangeButtonColor,
                            AppConstantsTextStyle.kNormalWhiteNotoTextStyle),
                        SizedBox(
                          height: 17.h,
                        ),
                        _iconCOntainer(
                            "Add customer ",
                            "assets/userVector.svg",
                            AppColors.kWhiteColor,
                            AppConstantsTextStyle.kNormalOrangeNotoTextStyle)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 90.h,
                      width: 155.w,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total this month",
                            style:
                                AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                          ),
                          Text(
                            "174",
                            style: AppConstantsTextStyle
                                .kNormalOrangeNotoTextStyle,
                          ),
                          Text(
                            "scheduled statuses",
                            style:
                                AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _iconCOntainer(
      String title, String icon, Color color, TextStyle textStyle) {
    return Container(
      height: 35.h,
      width: 150.w,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 15.w,
            height: 18.h,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: textStyle,
          )
        ],
      ),
    );
  }
}
