import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'dart:async';

import 'package:social_crm/view/widgets/custome_largebutton.dart';

class VideoUploadStep3Screen extends StatefulWidget {
  @override
  _VideoUploadStep3ScreenState createState() => _VideoUploadStep3ScreenState();
}

class _VideoUploadStep3ScreenState extends State<VideoUploadStep3Screen> {
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
            SizedBox(height: 20.h),
            Padding(
              padding:  EdgeInsets.only(left: 16.0.w, right: 8.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5, // 70% of screen height
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Text("הסרטון נחתך בהצלחה!", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 16.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return GridTile(
                              child: _buildContainerWithIcon(),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(16.0),
                        child: ConstantLargeButton(text: "לתזמון הסטטוס ←",
                            onPressed: (){
                          
                          Navigator.push(context,
                              MaterialPageRoute(builder: (i)=>CalendarScreen()));

                            }),
                      )
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

  Widget _buildContainerWithIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/videoImgPreview.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: Icon(Icons.delete, color: Colors.red, size: 24.0),
          ),
        ],
      ),
    );
  }

}
