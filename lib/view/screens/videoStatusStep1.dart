import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../Model/Status.dart';
import '../../utilis/constant_colors.dart';
import '../../utilis/constant_textstyles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custome_largebutton.dart';
import '../widgets/customerSlider.dart';
import 'VideoStatusStep2.dart';



class VideoUploadStep1Screen extends StatefulWidget {
  @override
  _VideoUploadStep1ScreenState createState() => _VideoUploadStep1ScreenState();
}

class _VideoUploadStep1ScreenState extends State<VideoUploadStep1Screen> {
  File? selectedVideo; // Store selected video file
  final Trimmer _trimmer = Trimmer();
  late final File file;
  double _startValue = 0.0;
  double _endValue = 15.0;
  double _selectedDuration = 15.0;
  StatusData? statusData;
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
                height: 370.h, // Adjusted height to accommodate video preview and controls
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.w),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: CustomSlider(
                          minValue: 15,
                          maxValue: 45,
                          initialValue: 15,
                          onValueChanged: (value) {
                            setState(() {
                              _selectedDuration = value;
                            });
                          },

                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ConstantLargeButton(
                          text: 'לחיתוך הסרטון ←',
                          onPressed: () {
                            _trimVideo();

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSelectionContainer() {
    return GestureDetector(
      onTap: () => _selectVideo(),
      child: Container(
        height: 65.h,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: AppColors.kWhiteColor40Opacity,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'לחצו כאן לבחירת הקובץ הוידאו',
              textAlign: TextAlign.center,
              style: AppConstantsTextStyle.heading2Style,
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _selectVideo() async {
    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        selectedVideo = File(video.path);
        _initializeTrimmer();
      });
    }
  }

  void _initializeTrimmer() async {
    await _trimmer.loadVideo(videoFile: selectedVideo!);
    setState(() {});
  }

  Future<void> _trimVideo() async {
    if (selectedVideo == null) {
      // Handle case where no video is selected
      return;
    }

    await _trimmer.saveTrimmedVideo(
      startValue: 0.0,
      endValue: _selectedDuration,
      onSave: (String? outputPath) {
        print("Video Ouput Path: ${outputPath}");
        if (outputPath != null) {
          setState(() {
            // Update StatusData with the trimmed video path
            statusData = StatusData(videoPath: outputPath);
          });
          print('Selected Video: ${statusData?.videoPath}');

          // Create a new StatusData instance with the updated video path
          StatusData VideostatusData = StatusData(
            videoPath: statusData?.videoPath,
          );

          print('Before sending to Calendar Screen: ${VideostatusData.videoPath}');

          // Navigate to CalendarScreen after updating the statusData
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoUploadStep2Screen(
              statusData: VideostatusData,
            )),
          );
        }
      },
    );
  }




}





