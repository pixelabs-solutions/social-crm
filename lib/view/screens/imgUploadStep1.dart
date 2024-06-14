import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class ImageUploadStep1Screen extends StatefulWidget {
  @override
  _ImageUploadStep1ScreenState createState() => _ImageUploadStep1ScreenState();
}

class _ImageUploadStep1ScreenState extends State<ImageUploadStep1Screen> {
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
                      'Status Upload',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 8.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5, // 70% of screen height
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h,),
                      Text("Uploading Files", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.h,),
                      _buildVideoSelectionContainer(),
                      SizedBox(height: 10.h,),
                      Text("Preview", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        height: 120.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: _buildContainerWithIcon(),
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ConstantLargeButton(
                          text: "Schedule Status -->",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (i) => CalendarScreen()));
                          },
                        ),

                      ),
                      SizedBox(height: 10.h,),
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
      width: 85.0.w,
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
  Widget _buildVideoSelectionContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 55.h,
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
