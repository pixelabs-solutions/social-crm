import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:resize/resize.dart';

import '../../utilis/constant_colors.dart';
import '../../utilis/constant_textstyles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custome_largebutton.dart';
import 'VideoStatusStep2.dart';



class VideoUploadStep1Screen extends StatelessWidget {
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
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Text(
                      'Status Upload',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding:  EdgeInsets.only(left: 14.0.w, right: 10.w, top: 10.h),
              child: Container(
                height: 350.h,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0.h, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Upload a video file",
                        style: AppConstantsTextStyle.heading2Style,
                      ),
                      SizedBox(height: 20.0.h),
                      _buildVideoSelectionContainer(),
                      SizedBox(height: 20.0.h),
                      Text(
                        'Select Cut Duration',
                        style: AppConstantsTextStyle.heading2Style,
                      ),
                      SizedBox(height: 10.0.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: CustomSlider(minValue: 15, maxValue: 45, initialValue: 15,),
                      ),
                      SizedBox(height: 20.0.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ConstantLargeButton(
                          text: 'Cut Video',
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (k)=>VideoUploadStep2Screen())
                            );
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              'Choose here to select file',
              textAlign: TextAlign.center,
              style: AppConstantsTextStyle.heading2Style,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double initialValue;
  final ValueChanged<double>? onChanged;

  CustomSlider({
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    this.onChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.0;
  double _dragPosition = 0.0;
  double _dragPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _onDragStart(details.localPosition.dx);
      },
      onHorizontalDragUpdate: (details) {
        _onDragUpdate(details.localPosition.dx);
      },
      onHorizontalDragEnd: (details) {
        _onDragEnd();
      },
      onTapDown: (details) {
        _onTap(details.localPosition.dx);
      },
      onTapUp: (details) {
        _onTapUp();
      },
      child: Container(
        width: double.infinity,
        height: 55.0, // Increased height by 5
        child: CustomPaint(
          painter: _SliderPainter(
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            value: _value,
            dragPercentage: _dragPercentage,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  void _onDragStart(double startX) {
    setState(() {
      _dragPosition = startX;
      _calculateDragPercentage(startX);
    });
  }

  void _onDragUpdate(double newX) {
    setState(() {
      _dragPosition = newX;
      _calculateDragPercentage(newX);
      _updateValue();
    });
  }

  void _onDragEnd() {
    setState(() {
      _dragPercentage = 0.0;
    });
  }

  void _onTap(double tapX) {
    setState(() {
      _dragPosition = tapX;
      _calculateDragPercentage(tapX);
      _updateValue();
    });
  }

  void _onTapUp() {
    setState(() {
      _dragPercentage = 0.0;
    });
  }

  void _calculateDragPercentage(double position) {
    _dragPercentage = (position / context.size!.width).clamp(0.0, 1.0);
  }

  void _updateValue() {
    _value = widget.minValue +
        (_dragPercentage * (widget.maxValue - widget.minValue));
    widget.onChanged?.call(_value);
  }
}

class _SliderPainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final double value;
  final double dragPercentage;

  _SliderPainter({
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.dragPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final Paint activeTrackPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final double trackLength = size.width - 16.0;
    final double trackY = size.height / 2;

    // Draw inactive track
    canvas.drawLine(
      Offset(8.0, trackY),
      Offset(size.width - 8.0, trackY),
      trackPaint,
    );

    // Draw active track
    double activeTrackEnd = 8.0 + (trackLength * (value - minValue) / (maxValue - minValue));
    if (dragPercentage > 0.0) {
      activeTrackEnd = 8.0 + (trackLength * (value - minValue) / (maxValue - minValue)) +
          (trackLength / (maxValue - minValue) * dragPercentage);
    }

    canvas.drawLine(
      Offset(8.0, trackY),
      Offset(activeTrackEnd, trackY),
      activeTrackPaint,
    );

    // Draw thumb
    final Paint thumbPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    double thumbX = 8.0 + (trackLength * (value - minValue) / (maxValue - minValue));
    if (dragPercentage > 0.0) {
      thumbX = 8.0 + (trackLength * (value - minValue) / (maxValue - minValue)) +
          (trackLength / (maxValue - minValue) * dragPercentage);
    }

    canvas.drawCircle(
      Offset(thumbX, trackY),
      18.0,
      thumbPaint,
    );

    // Draw value inside the thumb
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${value.toInt()}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(thumbX - textPainter.width / 2, trackY - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


