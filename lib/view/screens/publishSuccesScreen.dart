import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class PublishSuccess extends StatefulWidget {
  const PublishSuccess({Key? key}) : super(key: key);

  @override
  State<PublishSuccess> createState() => _PublishSuccessState();
}

class _PublishSuccessState extends State<PublishSuccess> {
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
                    'Something awaits your followers',
                    style: AppConstantsTextStyle.heading2Style,
                  ),
                  // Optionally add arrows for month navigation here
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding:  EdgeInsets.only(left: 14.w, right: 8.w, top: 9.h),
              child: Container(
                height: 300.0.h, // Adjust height as needed
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  child: Stack(

                    children: [
                      // Image centered and covering the container
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.asset(
                            height: 300.h,
                            'assets/backImg.jpeg', // Replace with your image URL
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      // Text overlay
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            'Status Published Succesfuly',
                            style: AppConstantsTextStyle.heading2Style
                          ),
                        ),
                      ),
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
}
