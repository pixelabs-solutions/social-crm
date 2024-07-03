import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/Model/statuslist.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

import '../../viewModel/Status_viewModel.dart';
import 'StatusUploadScreen.dart';
import 'adding_customer.dart';
import 'statusScheduleMonthView.dart';

class StatusCalendar extends StatefulWidget {
  const StatusCalendar({super.key});

  @override
  State<StatusCalendar> createState() => _StatusCalendarState();
}

class _StatusCalendarState extends State<StatusCalendar> {
  final EventList<Event> _markedDates = EventList<Event>(events: {});


  void _markFridays(List<Statuses>? statuses) {
    if (statuses!.isNotEmpty) {
      for (int i = 0; i < statuses.length; i++) {
        DateTime dateTime = DateTime.parse("${statuses[i].scheduleDate}");
        _markedDates.add(
          dateTime,
          Event(
            date: dateTime,
            dot: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.red,
              height: 2.0,
              width: 5.0,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TextStatusViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: const HomeAppBar(),
        body: ChangeNotifierProvider(
            create: (_) => TextStatusViewModel(),
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
                        const SizedBox(width: 2),
                        Text(
                          'לוח פרסומים  ',
                          style: AppConstantsTextStyle.heading1Style,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                        height: 310.h, // 70% of screen height
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Consumer<TextStatusViewModel>(
                            builder: (context, viewModel, child) {
                          if (viewModel.statusIsLoading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              backgroundColor: AppColors.orangeButtonColor,
                            ));
                          }
                          _markFridays(viewModel.statusList?.data?.statuses);
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.0.h, horizontal: 16.w),
                                child: CalendarCarousel<Event>(
                                  weekendTextStyle:
                                      const TextStyle(color: Colors.white),
                                  thisMonthDayBorderColor: Colors.grey,
                                  headerTextStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                  daysTextStyle:
                                      const TextStyle(color: Colors.white),
                                  weekdayTextStyle:
                                      const TextStyle(color: Colors.white),
                                  weekFormat: false,
                                  height: 280.h,
                                  selectedDayButtonColor: Colors.white,
                                  selectedDayTextStyle: const TextStyle(
                                      color: AppColors.primaryColor),
                                  todayButtonColor: Colors.transparent,
                                  locale: 'en',
                                  headerMargin:
                                      EdgeInsets.symmetric(vertical: 10.0.h),
                                  prevDaysTextStyle: const TextStyle(
                                      color: Colors
                                          .white), // Previous month arrow color
                                  nextDaysTextStyle:
                                      const TextStyle(color: Colors.white),
                                  iconColor: AppColors.orangeButtonColor,
                                  markedDatesMap: _markedDates,
                                  markedDateShowIcon: true,
                                  markedDateCustomShapeBorder:
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppColors.orangeButtonColor),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  inactiveDaysTextStyle: const TextStyle(
                                    backgroundColor: Colors.orange,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  markedDateMoreCustomDecoration:
                                      const BoxDecoration(
                                    color: Colors.orange,
                                  ),
                                  markedDateCustomTextStyle: const TextStyle(

                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  onDayPressed:
                                      (DateTime date, List<Event> events) {
                                    if (events.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StatusScheduleMonthView(
                                            selectedDate: date,
                                            status: viewModel
                                                .statusList?.data?.statuses,
                                          ),
                                        ),
                                      );
                                    }
                                  }, // Next month arrow color
                                ),
                              ),
                            ],
                          );
                        })),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 5.w, right: 5.w),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            _iconCOntainer(
                                "העלאת סטטוס ",
                                "assets/mobileIcon.svg",
                                AppColors.orangeButtonColor,
                                AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (o) => StatusUploadScreen()));
                            }),
                            SizedBox(
                              height: 17.h,
                            ),
                            _iconCOntainer(
                                "הוספת לקוח ",
                                "assets/userVector.svg",
                                AppColors.kWhiteColor,
                                AppConstantsTextStyle
                                    .kNormalOrangeNotoTextStyle, onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (o) =>
                                          const AddingCustomerDetails()));
                            })
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
                                "סה”כ החודש ",
                                style: AppConstantsTextStyle
                                    .kNormalWhiteNotoTextStyle,
                              ),
                              Text(
                                "${viewModel.statusSpecificCount}",
                                style: AppConstantsTextStyle
                                    .kNormalOrangeNotoTextStyle,
                              ),
                              Text(
                                "סטטוסים מתוזמנים",
                                style: AppConstantsTextStyle
                                    .kNormalWhiteNotoTextStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _iconCOntainer(
    String title,
    String icon,
    Color color,
    TextStyle textStyle, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.h,
        width: 150.w,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 12.w,
              height: 15.h,
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
      ),
    );
  }
}
