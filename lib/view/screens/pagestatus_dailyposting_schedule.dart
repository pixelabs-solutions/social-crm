// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/Model/status.dart';
import 'package:social_crm/Model/statuslist.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/calendar_screen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'video_image.dart';

class DailyPostingSchedule extends StatefulWidget {
  const DailyPostingSchedule({super.key, required this.statusData});

  final Statuses statusData;

  @override
  State<DailyPostingSchedule> createState() => _DailyPostingScheduleState();
}

class _DailyPostingScheduleState extends State<DailyPostingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
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
                  SizedBox(
                    width: 13.w,
                  ),
                  Center(
                    child: Text(
                      'עריכת פרטי סטטוס',
                      style: AppConstantsTextStyle.heading2Style,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.only(top: 12.0.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.arrow_back_ios_outlined,
                                color: AppColors.orangeButtonColor),
                            Column(
                              children: [
                                labelText("15/06/2024"),
                                showText("08:10")
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios_outlined,
                                color: AppColors.orangeButtonColor),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 5.h,
                        ),
                        _customRow("סוג סטטוס"),
                        SizedBox(
                          height: 8.h,
                        ),
                        labelText("שם לקוח"),
                        showText("אליהו מלכה"),
                        SizedBox(
                          height: 5.h,
                        ),
                        labelText("טלפון"),
                        showText("03114858538"),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            "תצוגה מקדימה",
                            style: AppConstantsTextStyle
                                .kNormalOrangeNotoTextStyle,
                          ),
                        ),
                        if (widget.statusData.statusType == "image") ...[
                          Container(
                            height: 80.h,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: 25.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Row(
                                  children: List.generate(
                                      getUrlFromJson(widget.statusData.content)
                                          .length, (index) {
                                return Container(
                                    height: 80.h,
                                    width: 80.w,
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(getUrlFromJson(
                                                widget.statusData
                                                    .content)[index])),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          getUrlFromJson(getUrlFromJson(
                                                  widget.statusData.content)
                                              .removeAt(index));
                                        });
                                      },
                                      child: const Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          CupertinoIcons.delete_solid,
                                          color: Colors.red,
                                          size: 22,
                                        ),
                                      ),
                                    ));
                              })),
                            ),
                          )
                        ] else ...[
                          VideoThumbtitle(statusData: widget.statusData)
                        ],
                        ConstantLargeButton(
                          text: "לשנות את זמני הפרסום →",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (i) => CalendarScreen(
                                        statusData: StatusData(
                                            statusId: widget.statusData.id,
                                            contentType:
                                                widget.statusData.statusType,
                                            isEditApi: true,
                                            // videoPath: widget.statusData.statusType != "image"?,
                                            imagePaths: widget.statusData
                                                        .statusType ==
                                                    "image"
                                                ? getUrlFromJson(
                                                    widget.statusData.content)
                                                : extractUrlsFromJsonString(
                                                    widget.statusData
                                                        .content)))));
                          },
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<String> getUrlFromJson(String? jsonString) {
    Map<String, dynamic> jsonObject = jsonDecode(jsonString!);
    List<dynamic> images = jsonObject['images'];
    return images.map((image) => image['url'] as String).toList();
  }

  Widget statusContainer(String icon) {
    return Container(
      height: 90.h,
      width: 75.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.38),
              Color.fromRGBO(255, 157, 0, 0.40), // #FF9D00 with 40% opacity
            ],
            begin: Alignment.topLeft, // Adjust as needed
            end: Alignment.bottomRight, // Adjust as needed
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Image.asset(
        icon,
        width: 30.w,
        height: 30.h,
      ),
    );
  }

  Widget _customRow(String statusType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/deleteIcon.svg",
          width: 18.w,
          height: 18.h,
          color: AppColors.orangeButtonColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/photoStatusIcon.svg",
                width: 12.w,
                height: 12.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                statusType,
                style: AppConstantsTextStyle.kNormalWhiteTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget labelText(String text) {
    return Text(
      text,
      style: AppConstantsTextStyle.kNormalWhiteTextStyle,
    );
  }

  Widget showText(String text) {
    return Text(
      text,
      style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
    );
  }
}

class VideoThumbtitle extends StatelessWidget {
  final Statuses statusData; // Replace with your actual data type

  const VideoThumbtitle({super.key, required this.statusData});

  @override
  Widget build(BuildContext context) {
    // Extract URLs from JSON string
    List<String> videoUrls = extractUrlsFromJsonString(statusData.content);

    return Container(
      height: 80.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 25.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          children: List.generate(videoUrls.length, (index) {
            return Container(
              height: 80.h,
              width: 80.w,
              margin:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: VideoImage(videoUrl: videoUrls[index]),
              ),
            );
          }),
        ),
      ),
    );
  }
}

List<String> extractUrlsFromJsonString(String? jsonString) {
  Map<String, dynamic> json = jsonDecode(jsonString!);
  List<dynamic> videos = json['videos'];
  return videos.map((video) => video['url'] as String).toList();
}
