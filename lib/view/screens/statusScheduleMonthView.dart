import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

class StatusScheduleMonthView extends StatefulWidget {
  const StatusScheduleMonthView({Key? key}) : super(key: key);

  @override
  State<StatusScheduleMonthView> createState() => _StatusScheduleMonthViewState();
}

class _StatusScheduleMonthViewState extends State<StatusScheduleMonthView> {
  DateTime _selectedDate = DateTime.now();

  void _goToNextDay() {
    setState(() {
      _selectedDate = _getNextWeekStartDate(_selectedDate);
    });
  }

  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _getPreviousWeekStartDate(_selectedDate);
    });
  }

  DateTime _getNextWeekStartDate(DateTime currentDate) {
    // Calculate the next week's starting date
    return currentDate.add(Duration(days: 7 - currentDate.weekday + 1));
  }

  DateTime _getPreviousWeekStartDate(DateTime currentDate) {
    // Calculate the previous week's starting date
    return currentDate.subtract(Duration(days: currentDate.weekday));
  }

  List<Map<String, String>> _statusEntries = [
    {"time": "10:00 AM", "icon": "status_icon_1"},
    {"time": "02:00 PM", "icon": "status_icon_2"},
  ];

  List<Widget> _buildDayWidgets() {
    List<Widget> dayWidgets = [];
    DateTime startDate = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    DateTime endDate = startDate.add(Duration(days: 6));

    for (DateTime day = startDate; day.isBefore(endDate) || day.isAtSameMomentAs(endDate); day = day.add(Duration(days: 1))) {
      dayWidgets.add(
        Column(
          children: [
            Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _statusEntries.map((entry) {
                      return Container(
                        margin: EdgeInsets.only(left: 4.0, right: 4.0),
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteColor40Opacity,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/smalImgIcon.svg"),
                            SizedBox(width: 5),
                            Text(entry['time']!, style: AppConstantsTextStyle.paragraph2Style),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    DateFormat('dd').format(day), // Display day of the month
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return dayWidgets;
  }

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
                    'Status Schedule',
                    style: AppConstantsTextStyle.heading1Style,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Padding(
              padding: EdgeInsets.only(left: 14.0.w, right: 8.w),
              child: Container(
                height: 350.0.h, // Static height for the container
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                  child: Column(
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
                              onPressed: _goToPreviousDay,
                            ),
                            Text(
                              '${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                              style: AppConstantsTextStyle.heading1Style,
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                              ),
                              onPressed: _goToNextDay,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0), // Add spacing between header and content
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildDayWidgets(),
                          ),
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
}
