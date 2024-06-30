import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'pagestatus_dailyposting_schedule.dart';

class StatusScheduleMonthView extends StatefulWidget {
  final DateTime selectedDate;
  const StatusScheduleMonthView({
    super.key,
    required this.selectedDate,
  });

  @override
  State<StatusScheduleMonthView> createState() =>
      _StatusScheduleMonthViewState();
}

class _StatusScheduleMonthViewState extends State<StatusScheduleMonthView> {
  DateTime _selectedDate = DateTime.now();

  void _goToNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  final List<Map<String, String>> _statusEntries = [
    {"time": "10:00 AM", "icon": "status_icon_1"},
    {"time": "02:00 PM", "icon": "status_icon_2"},
    {"time": "10:00 AM", "icon": "status_icon_1"},
    {"time": "02:00 PM", "icon": "status_icon_2"},
    {"time": "10:00 AM", "icon": "status_icon_1"},
    {"time": "02:00 PM", "icon": "status_icon_2"},
    // Add more entries as needed
  ];

  List<Widget> _buildHourWidgets() {
    List<Widget> hourWidgets = [];

    // Example: Simulating hours for the selected day (adjust as per your logic)
    List<String> hours = [
      "10:00 AM",
      "11:00 AM",
      "12:00 PM",
      "01:00 PM",
      "02:00 PM",
      "03:00 PM",
      "04:00 PM",
      "01:00 PM",
      "02:00 PM",
      "03:00 PM",
      "04:00 PM"
    ];

    for (String hour in hours) {
      hourWidgets.add(
        Column(
          children: [
            const Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _statusEntries
                          .where((entry) => entry['time'] == hour)
                          .map((entry) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DailyPostingSchedule()),
                            );
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: AppColors.kWhiteColor40Opacity,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset("assets/smalImgIcon.svg"),
                                const SizedBox(width: 5),
                                Text(entry['time']!,
                                    style:
                                        AppConstantsTextStyle.paragraph2Style),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    hour,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return hourWidgets;
  }

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
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                    'העלאת סטטוס',
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 14.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(Icons.arrow_back_ios_outlined,
                                    color: Colors.white),
                              ),
                              onPressed: _goToPreviousDay,
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(_selectedDate),
                              style: AppConstantsTextStyle.heading1Style,
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    color: Colors.white),
                              ),
                              onPressed: _goToNextDay,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height:
                              8.0), // Add spacing between header and content
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildHourWidgets(),
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
