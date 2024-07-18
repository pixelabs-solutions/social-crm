import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import '../../Model/statuslist.dart';
import '../../viewModel/StatusDetails_viewModel.dart';
import 'pagestatus_dailyposting_schedule.dart';
import 'text_edit_screen.dart';
import 'video_view_screen.dart';


class StatusHistoryView extends StatefulWidget {
  const StatusHistoryView({super.key});

  @override
  _StatusHistoryViewState createState() => _StatusHistoryViewState();
}

class _StatusHistoryViewState extends State<StatusHistoryView> {
  late StatusHistoryViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StatusHistoryViewModel();
    viewModel.fetchStatusHistory();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusHistoryViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: const HomeAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        'הסטוריית סטטוסים ( 24 שעות )',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Consumer<StatusHistoryViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orangeButtonColor,
                        ),
                      );
                    } else if (viewModel.statusHistory.isEmpty) {
                      return const Center(
                        child: Text(
                          'No status history available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        margin: const EdgeInsets.all(12.0),
                        padding: EdgeInsets.only(top: 12.0.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.statusHistory.length,
                          itemBuilder: (context, index) {
                            final status = viewModel.statusHistory[index];
                            return Column(
                              children: [
                                StatusRow(
                                  iconPath: 'assets/eyeIcon.svg',
                                  views: status.views.toString(),
                                  time: status.scheduleTime ?? '',
                                  rightIconPath: 'assets/e6.png',
                                  statusType: status.statusType ?? '',
                                  status: status,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: const Divider(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String iconPath;
  final String views;
  final String time;
  final String rightIconPath;
  final String statusType;
  final Statuses status;

  const StatusRow({
    super.key,
    required this.iconPath,
    required this.views,
    required this.time,
    required this.rightIconPath,
    required this.statusType,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0.h, right: 20.h, top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 20.h,
              ),
              SizedBox(width: 12.w),
              Text(
                views,
                style: AppConstantsTextStyle.heading2Style,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatusDialog(statusContent: status.content!, statusType: statusType);
                    },
                  );
                },
                child: _buildRightIcon(statusType, status.content),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightIcon(String statusType, String? content) {
    List<String> imageUrls = [];
    String? caption;
    Color backgroundColor = AppColors.primaryColor; // Default value
    Color textCaptionColor = AppColors.primaryColor;
    if (statusType == 'text' && status.content != null) {
      try {
        final contentJson = jsonDecode(status.content!);
        caption = contentJson['caption'] ?? "No caption available.";
        String backgroundColorCode = contentJson['background_color'] ?? "#FFFFFF";
        String CaptionColorCode = contentJson['caption_color'] ?? AppColors.primaryColor;
        backgroundColor = Color(int.parse(backgroundColorCode.replaceFirst('#', '0xff')));
        textCaptionColor = Color(int.parse(CaptionColorCode.replaceFirst('#', '0xff')));

      } catch (e) {
        caption = "Error parsing content.";
        print("Error parsing content: $e");
      }
    } else if (status.content != null) {
      try {
        final contentJson = jsonDecode(status.content!);
        if (contentJson['images'] != null) {
          imageUrls = List<String>.from(contentJson['images'].map((image) => image['url']));
        }
        // if (contentJson['videos'] != null) {
        //   videoUrls = List<String>.from(contentJson['videos'].map((video) => video['url']));
        // }
      } catch (e) {
        print("Error parsing content for images or videos: $e");
      }
    }
    if (statusType == 'text') {
      return Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.scaffoldColor
            ),
          shape: BoxShape.circle,
          color: backgroundColor//extarct backgrounf from response...,
        ),
        child: Center(
          child: Text(
            caption ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color:textCaptionColor,
                fontSize: 12.sp),
          ),
        ),
      );
    } else if (statusType == 'image') {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.scaffoldColor
            )
        ),
        child: ClipOval(
          child: Image.network(
           imageUrls.first,//show here the first image of list from imageUrls
            width: 40.h,
            height: 40.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (statusType == 'video') {
      return Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
            border: Border.all(
                color: AppColors.scaffoldColor
            )
        ),
        child: Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      );
    }
    return Container(); // Fallback if no type matches
  }
}

class StatusDialog extends StatefulWidget {
  final String statusContent;
  final String statusType;

  const StatusDialog({Key? key, required this.statusContent, required this.statusType}) : super(key: key);

  @override
  _StatusDialogState createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  bool _isLoading = true;
  String? caption;
  Color dialogBackgroundColor = AppColors.primaryColor;
  List<String> imageUrls = [];
  List<String> videoUrls = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      if (widget.statusType == 'text' && widget.statusContent.isNotEmpty) {
        final contentJson = jsonDecode(widget.statusContent);
        caption = contentJson['caption'] ?? "No caption available.";
        String backgroundColorCode = contentJson['background_color'] ?? "#FFFFFF";
        dialogBackgroundColor = Color(int.parse(backgroundColorCode.replaceFirst('#', '0xff')));
      } else if (widget.statusContent.isNotEmpty) {
        final contentJson = jsonDecode(widget.statusContent);
        if (contentJson['images'] != null) {
          imageUrls = List<String>.from(contentJson['images'].map((image) => image['url']));
        }
        if (contentJson['videos'] != null) {
          videoUrls = List<String>.from(contentJson['videos'].map((video) => video['url']));
        }
      }
    } catch (e) {
      caption = "Error loading content.";
      print("Error parsing content: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text("סטטוס טקסט", // Title in Hebrew
                    style: TextStyle(
                        fontSize: 14.sp, color: AppColors.orangeButtonColor, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    if (caption != null && caption!.isNotEmpty)
                      Center(child: Text(caption!, textAlign: TextAlign.center)),
                    if (imageUrls.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: imageUrls.map((url) {
                          return Image.network(
                            url,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                    if (videoUrls.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: videoUrls.map((url) {
                          return GestureDetector(
                            onTap: () {
                              print('Here is Video Path: $url');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (i) => VideoViewScreen(videoUrl: url),
                                ),
                              );
                            },
                            child: Container(

                              width: 80.w,
                              height: 80.h,
                              color: Colors.black,
                              child: Center(child: Icon(Icons.play_arrow, color: Colors.white)),
                            ),
                          );
                        }).toList(),
                      ),
                    if (caption == null && imageUrls.isEmpty && videoUrls.isEmpty)
                      Center(child: Text("No content available.", textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.h),
              child: ConstantLargeButton(
                  text: "OK",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

