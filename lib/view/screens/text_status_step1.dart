import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/calendar_screen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../viewModel/status_viewmodel.dart';

class TextStatusStep1Screen extends StatefulWidget {
  final String? textCaption;
  const TextStatusStep1Screen({Key? key, this.textCaption}) : super(key: key);

  @override
  State<TextStatusStep1Screen> createState() => _TextStatusStep1ScreenState();
}

class _TextStatusStep1ScreenState extends State<TextStatusStep1Screen> {

  bool isRtl = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Received textCaption: ${widget.textCaption}');
    _textEditingController=TextEditingController(text: widget.textCaption); // Initialize with the passed textCaption or empty text
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextStatusViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: const HomeAppBar(),
        body: SingleChildScrollView(
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
                        'העלה סטטוס',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0.h),
                Padding(
                  padding: EdgeInsets.only(left: 14.0.w, right: 8.w),
                  child: Consumer<TextStatusViewModel>(
                    builder: (context, viewModel, child) {
                      if (_textEditingController.text != viewModel.textStatus.text) {
                        // _textEditingController.text = viewModel.textStatus.text!;
                      }
                      return Container(
                        height: 370.0.h, // Adjust height as needed
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 2.h),
                              // Text editing canvas
                              Expanded(
                                child: Stack(
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(viewModel.textStatus.backgroundColorHex!.replaceFirst('#', '0xff'))),
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12.0.w, right: 10.w),
                                            child: TextFormField(


                                              controller: _textEditingController,
                                              onChanged: (text){
                                                viewModel.setText(text);
                                              },
                                              style: const TextStyle(
                                                fontFamily: "Noto Sans Hebrew",
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: null,
                                              textAlign: TextAlign.center,
                                               // Set text direction to LTR
                                              decoration: const InputDecoration(
                                                // hintText: 'הזן את הסטטוס שלך',
                                                border: InputBorder.none,
                                              ),
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
                                        children: [
                                          Colors.red,
                                          Colors.blue,
                                          Colors.green,
                                          Colors.yellow,
                                          Colors.purple,
                                          Colors.orange,
                                          Colors.teal,
                                        ].map((color) {
                                          return GestureDetector(
                                            onTap: () {
                                              viewModel.setBackgroundColor(color);
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
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              ConstantLargeButton(
                                text: "תזמן סטטוס →",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalendarScreen(statusData: viewModel.textStatus),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
