import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:video_player/video_player.dart';
import '../../Model/status.dart';
import '../../utilis/constant_colors.dart';
import '../../utilis/constant_textstyles.dart';
import '../../utilis/variables.dart';
import '../../viewModel/status_viewmodel.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custome_largebutton.dart';
import '../widgets/customerSlider.dart';

class VideoUploadStep1Screen extends StatefulWidget {
  const VideoUploadStep1Screen({super.key});

  @override
  _VideoUploadStep1ScreenState createState() => _VideoUploadStep1ScreenState();
}

class _VideoUploadStep1ScreenState extends State<VideoUploadStep1Screen> {
  double selectedRange = 0.0;
  VideoPlayerController? _videoController;
  double? videoDuration;
  StatusData? statusData;

  void _initializeVideoController() {
    _videoController = VideoPlayerController.file(Variables.selectedVideo!)
      ..initialize().then((_) {
        setState(() {
          videoDuration =
              (_videoController!.value.duration.inSeconds).toDouble();
        });
        _videoController!.dispose();
      });
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
                    Center(
                      child: Text(
                        'העלאת סטטוס ',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 14.0.w, right: 10.w, top: 10.h),
                child: Container(
                  height: 370
                      .h, // Adjusted height to accommodate video preview and controls
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "העלאת קובץ וידיאו  ",
                          style: AppConstantsTextStyle.heading2Style,
                        ),
                        SizedBox(height: 20.0.h),
                        _buildVideoSelectionContainer(),
                        SizedBox(height: 20.0.h),
                        // Show video preview if video is selected
                        SizedBox(height: 20.0.h),
                        Text(
                          'סמנו את כמות השניות לכל סטטוס',
                          style: AppConstantsTextStyle.heading2Style,
                        ),
                        SizedBox(height: 10.0.h),
                        videoDuration != null
                            ? Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: CustomSlider(
                                  minValue: 1,
                                  maxValue: videoDuration!,
                                  initialValue: 1,
                                  onValueChanged: (value) {
                                    setState(() {
                                      selectedRange = value;
                                    });
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(height: 20.0.h),
                        Consumer<TextStatusViewModel>(
                            builder: (context, viewModel, child) {
                          if (viewModel.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ConstantLargeButton(
                              text: 'לחיתוך הסרטון ←',
                              onPressed: () {
                                if (Variables.selectedVideo == null) {
                                  Fluttertoast.showToast(
                                    msg: 'No video selected',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  return;
                                } else {
                                  viewModel.postVideoforSpilts(
                                      context, selectedRange);
                                }
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSelectionContainer() {
    return GestureDetector(
      onTap: () => _selectVideo(),
      child: Container(
        height: 65.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: AppColors.kWhiteColor40Opacity,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'לחצו כאן לבחירת הקובץ הוידאו',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectVideo() async {
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        Variables.selectedVideo = File(video.path);
        // _initializeTrimmer();
      });
      _initializeVideoController();
    }
  }
}
