import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'dart:async';

import '../../Model/Status.dart';
import 'videoStatusStep3.dart';
// Import your next screen

class VideoUploadStep2Screen extends StatefulWidget {
  final StatusData? statusData;

  const VideoUploadStep2Screen({Key? key, this.statusData}) : super(key: key);
  @override
  _VideoUploadStep2ScreenState createState() => _VideoUploadStep2ScreenState();
}

class _VideoUploadStep2ScreenState extends State<VideoUploadStep2Screen> {
  late Timer _timer;
  int _start = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _navigateToNextScreen(); // Navigate after 10 seconds
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _navigateToNextScreen() {
    // Delay navigation to the next screen by 1 second for smooth transition
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CalendarScreen(
          statusData: widget.statusData,
        )), // Replace with your next screen widget
      );
    });
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
              padding: EdgeInsets.only(left: 14.0.w, right: 10.w, top:10.h),
              child: Container(
                height:350.h,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "האפלקצייה חותכת את הסרטון עבורך",
                        style: AppConstantsTextStyle.heading2Style,
                      ),
                      SizedBox(height: 20.0.h),
                      _buildCircularTimer(),
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

  Widget _buildCircularTimer() {
    return Container(
      width: 180.0.w,
      height: 180.0.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(180.0, 180.0),
            painter: _GradientBorderPainter(),
          ),
          Center(
            child: Text(
                '0:${_start.toString().padLeft(2, '0')}',
                style: AppConstantsTextStyle.heading2Style
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      colors: [AppColors.orangeButtonColor, Color(0xFF02FCC0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final double radius = size.width / 2;
    canvas.drawCircle(Offset(radius, radius), radius - 4.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
