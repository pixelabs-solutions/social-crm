import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/TimeSelectionScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/status.dart';

class CalendarScreen extends StatefulWidget {
  final StatusData? statusData;

  const CalendarScreen({super.key, this.statusData});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
                    'תזמון הסטטוס',
                    style: AppConstantsTextStyle.heading1Style,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 12.0.w, right: 8),
              child: Container(
                height: 400.h, // 70% of screen height

                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "בחירת יום ",
                      style: AppConstantsTextStyle.heading2Style,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.0.h, horizontal: 16.w),
                      child: CalendarCarousel<Event>(
                        onDayPressed: (DateTime date, List<Event> events) {
                          setState(() {
                            _currentDate = date;
                          });
                        },
                        weekendTextStyle: const TextStyle(color: Colors.white),
                        thisMonthDayBorderColor: Colors.grey,
                        headerTextStyle: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                        selectedDateTime: _currentDate,
                        daysTextStyle: const TextStyle(color: Colors.white),
                        weekdayTextStyle: const TextStyle(color: Colors.white),
                        weekFormat: false,
                        height: 275.h,
                        selectedDayButtonColor: Colors.white,
                        selectedDayTextStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        todayButtonColor: Colors.transparent,
                        todayTextStyle: const TextStyle(color: Colors.white),
                        locale: 'en',
                        headerMargin: EdgeInsets.symmetric(vertical: 10.0.h),
                        prevDaysTextStyle: const TextStyle(
                            color: Colors.white), // Previous month arrow color
                        nextDaysTextStyle: const TextStyle(color: Colors.white),
                        iconColor: AppColors
                            .orangeButtonColor, // Next month arrow color
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: ConstantLargeButton(
                          text: "לבחירת שעה ←",
                          onPressed: () {
                            print(
                                'Selected Video at Calendar Scrren: ${widget.statusData?.videoPath}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (i) => TimeSelection(
                                          statusData: StatusData(
                                            statusId:
                                                widget.statusData?.statusId,
                                            text: widget.statusData?.text,
                                            isEditApi:
                                                widget.statusData?.isEditApi,
                                            contentType:
                                                widget.statusData?.contentType,
                                            backgroundColorHex: widget
                                                .statusData?.backgroundColorHex,
                                            imagePaths:
                                                widget.statusData?.imagePaths,
                                            videoPath:
                                                widget.statusData?.videoPath,
                                            selectedDate: _currentDate,
                                          ),
                                        )));
                          }),
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
