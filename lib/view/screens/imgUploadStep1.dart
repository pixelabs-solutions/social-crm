import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/CalendarScreen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/Status.dart';

class ImageUploadStep1Screen extends StatefulWidget {
  @override
  _ImageUploadStep1ScreenState createState() => _ImageUploadStep1ScreenState();
}

class _ImageUploadStep1ScreenState extends State<ImageUploadStep1Screen> {
  List<File?> selectedImages = []; // Store selected images here, allow null for placeholders

  void _nextToCalendarScreen() {
    // Prepare StatusData with selected image paths
    List<String> imagePaths = selectedImages.map((file) => file!.path).toList();
    print('Selected Image Paths:');
    imagePaths.forEach((path) {
      print(path);
    });

    StatusData statusData = StatusData(
      imagePaths: imagePaths,
    );

    // Navigate to CalendarScreen and pass statusData
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarScreen(statusData: statusData)),
    );
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
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 8.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
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
                      Text("העלאת קבצים  ", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.h,),
                      _buildVideoSelectionContainer(),
                      SizedBox(height: 10.h,),
                      Text("תצוגה מקדימה", style: AppConstantsTextStyle.heading2Style,),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        height: 120.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length + 1, // Show selected images + add button
                          itemBuilder: (context, index) {
                            if (index < selectedImages.length) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: _buildContainerWithIcon(selectedImages[index]!),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: _buildAddImageButton(),
                              );
                            }
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ConstantLargeButton(
                          text: "לתזמון הסטטוס ←",
                          onPressed: () {
                            _nextToCalendarScreen(); // Navigate to CalendarScreen
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

  Widget _buildContainerWithIcon(File imageFile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w), // Add horizontal padding here
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              imageFile,
              width: 85.0.w,
              height: 85.0.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedImages.remove(imageFile); // Remove image from list
                });
              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Icon(Icons.delete, color: Colors.white, size: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: () => _selectImage(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding here
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
        child: Center(
          child: Icon(Icons.add, color: AppColors.primaryColor, size: 32.0),
        ),
      ),
    );
  }

  Widget _buildVideoSelectionContainer() {
    return GestureDetector(
      onTap: () => _selectImage(),
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
              'לחצו כאן לבחירת הקבצים',
              textAlign: TextAlign.center,
              style: AppConstantsTextStyle.heading2Style,
            ),
          ],
        ),
      ),
    );
  }

  void _selectImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImages.add(File(image.path));
      });
    }
  }
}
