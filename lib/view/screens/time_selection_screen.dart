import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/Model/statuslist.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../Model/status.dart';
import '../../utilis/shared_prefes.dart';
import '../../viewModel/status_viewmodel.dart';

class TimeSelection extends StatefulWidget {
  final StatusData? statusData;
  const TimeSelection({super.key, this.statusData});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  DateTime _selectedTime = DateTime.now();
  List<Statuses> statuses = [];
  StatusList? statusTodayList;
  String? scheduleDate;
  String? scheduleTime;
  bool isLoading = false;
  bool isTodayLoading = false;
  int todayStatusCount = 0;
  Dio dio = Dio();


  @override
  void initState() {
    super.initState();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    getTodayStatus();
  }


  Future<void> getTodayStatus() async {
    var token = await SharedPreferences.getInstance().then((value) => value.getString('token'));
    setState(() {
      isTodayLoading = true;
    });

    try {
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final Uri url = Uri.https(
        'scrm-apis.woo-management.com',
        '/api/status/list',
        {
          "start_date": todayDate,
          "end_date": todayDate,
        },
      );

      // Print the complete URL to verify query parameters
      print('Request URL: ${url.toString()}');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("The Today Status Api Called+++++++++");
      print('Today Status Api ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          statusTodayList = StatusList.fromJson(jsonResponse);
          todayStatusCount = statusTodayList!.data!.count ?? 0;
        });
      } else {
        throw Exception('Failed to load today\'s status');
      }
    } catch (e) {
      print('Error getting today status: $e');
    } finally {
      setState(() {
        isTodayLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime:
                                    TimeOfDay.fromDateTime(_selectedTime),
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
                                  widget.statusData?.selectedTime =
                                      _selectedTime;
                                });
                              }
                            },
                            child: Container(
                              height: 70.0.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                gradient: const RadialGradient(
                                  center: Alignment.center,
                                  radius: 2.0,
                                  colors: [
                                    Color(0xFF097382),
                                    Color(0xFFA3A3A3),
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                                boxShadow: const [
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
                                  const SizedBox(width: 8.0),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                      fontSize: 36.0.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
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
                          Text("זמנים תפוסים",
                              style: AppConstantsTextStyle.heading2Style),
                          SizedBox(height: 10.0.h),
                        Expanded(
                          child: isTodayLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.orangeButtonColor,
                            ),
                          )
                              : statusTodayList == null ||
                              statusTodayList!.data == null ||
                              statusTodayList!.data!.statuses!.isEmpty
                              ? Center(
                            child: Text("No statuses available for today"),
                          )
                              : Column(
                            children: _buildTimeRows(statusTodayList!.data!.statuses),
                          ),
                        ),



                          SizedBox(height: 20.0.h),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Consumer<TextStatusViewModel>(
                                builder: (context, viewModel, child) {
                              if (viewModel.isLoading) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.orangeButtonColor,
                                    ));
                              }
                              return ConstantLargeButton(
                                text: "לפרסום הסטטוס ←",
                                onPressed: () {
                                  if (widget.statusData?.selectedTime == null) {
                                    // Set selected time to current time + 1 minute
                                    _selectedTime = DateTime.now().add(Duration(minutes: 1));
                                    // Update the statusData with the new time
                                    widget.statusData?.selectedTime = _selectedTime;
                                  } else {
                                    // Ensure the selected time is already set
                                    widget.statusData?.selectedTime = _selectedTime;
                                  }
                                  if (widget.statusData?.isEditApi == true) {
                                    if (widget.statusData?.contentType ==
                                        "text") {
                                      viewModel.postTextEditStatus(
                                          context,
                                          widget.statusData?.statusId,
                                          widget.statusData?.backgroundColorHex,
                                          widget.statusData?.text,
                                          widget.statusData?.selectedDate
                                              .toString(),
                                          widget.statusData?.selectedTime
                                              .toString());
                                    } else if (widget.statusData?.contentType ==
                                        "image") {
                                      viewModel.postImageEditStatus(
                                          context,
                                          widget.statusData?.statusId,
                                          widget.statusData?.text,
                                          widget.statusData?.selectedDate
                                              .toString(),
                                          widget.statusData?.selectedTime
                                              .toString(),
                                          widget.statusData?.imagePaths);
                                    } else {
                                      viewModel.postEditVideoStatus(
                                          context,
                                          widget.statusData?.statusId,
                                          widget.statusData?.text,
                                          widget.statusData?.selectedDate
                                              .toString(),
                                          widget.statusData?.selectedTime
                                              .toString(),
                                          widget.statusData?.imagePaths);
                                    }
                                  } else {
                                    if (widget.statusData?.imagePaths != null) {
                                      viewModel.postImageStatus(
                                        context,
                                        widget.statusData?.text,
                                        widget.statusData?.selectedDate
                                            .toString(),
                                        widget.statusData?.selectedTime
                                            .toString(),
                                      );
                                    } else if (widget.statusData?.contentType ==
                                        "video") {
                                      viewModel.postVideoStatus(
                                        context,
                                        widget.statusData?.text,
                                        widget.statusData?.selectedDate
                                            .toString(),
                                        widget.statusData?.selectedTime
                                            .toString(),
                                      );
                                    } else {
                                      viewModel.postTextStatus(
                                        context,
                                        widget.statusData?.backgroundColorHex,
                                        widget.statusData?.text,
                                        widget.statusData?.selectedDate
                                            .toString(),
                                        widget.statusData?.selectedTime
                                            .toString(),
                                      );
                                    }
                                  }
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildTimeRows(List<Statuses>? statuses) {
    List<Widget> rows = [];

    if (statuses == null) {
      return rows; // Return empty list if statuses is null
    }

    for (int i = 0; i < statuses.length; i += 3) {
      List<Widget> rowChildren = [];

      for (int j = i; j < i + 3 && j < statuses.length; j++) {
        rowChildren.add(Expanded(child: _buildTimeContainer(statuses[j])));
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


  Widget _buildTimeContainer(Statuses status) {
    String svgAsset = 'assets/smalImgIcon.svg';
    String formattedTime = status.scheduleTime!.substring(0, 5);

    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      width: 70.0.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor40Opacity,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
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
            formattedTime,
            style: AppConstantsTextStyle.paragraph2Style,
          ),
        ],
      ),
    );
  }


}
