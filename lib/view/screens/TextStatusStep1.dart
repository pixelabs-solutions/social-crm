import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:social_crm/view/screens/statusScheduleMonthView.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class TextStatusStep1Screen extends StatefulWidget {
  const TextStatusStep1Screen({Key? key}) : super(key: key);

  @override
  State<TextStatusStep1Screen> createState() => _TextStatusStep1ScreenState();
}

class _TextStatusStep1ScreenState extends State<TextStatusStep1Screen> {
  final TextEditingController _textController = TextEditingController();
  double _textSize = 24.0;
  Color _canvasColor = Colors.white;
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                      'Upload Status',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0.h),
              Padding(
                padding: EdgeInsets.only(left: 14.0.w, right: 8.w),
                child: Container(
                  height: 370.0.h, // Adjust height as needed
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        // Text editing canvas
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: _canvasColor,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 12.0.w, right: 10.w),
                                    child: TextField(
                                      controller: _textController,
                                      style: TextStyle(
                                        fontFamily: "Noto Sans Hebrew",
                                        fontSize: _textSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,

                                      ),
                                      maxLines: null,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your status',
                                        border: InputBorder.none,

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5.h,
                                right: 5.w,
                                left: 5.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _colors.map((color) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _canvasColor = color;
                                        });
                                      },
                                      child: Container(
                                        width: 35.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(color: AppColors.primaryColor),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              // Vertical scroller
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ConstantLargeButton(
                          text: "Schedule Status -->",
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (o)=>CalendarScreen())
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  CustomSlider({required this.value, required this.onChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4.0,
        activeTrackColor: AppColors.scaffoldColor,
        inactiveTrackColor: AppColors.primaryColor,
        thumbColor:AppColors.primaryColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 18.0),
        overlayColor: AppColors.primaryColor2,
        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
      ),
      child: Slider(
        value: widget.value,
        min: 12.0,
        max: 36.0,
        onChanged: widget.onChanged,
      ),
    );
  }
}
