import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/screens/navigaton_main.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class PublishSuccess extends StatefulWidget {
  const PublishSuccess({super.key});

  @override
  State<PublishSuccess> createState() => _PublishSuccessState();
}

class _PublishSuccessState extends State<PublishSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const HomeAppBar(),
      body: Padding(
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
                  const Text(
                    'משהו חדש מחכה לעוקבים שלך',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // Optionally add arrows for month navigation here
                ],
              ),
            ),
            SizedBox(height: 10.0.h),
            Padding(
              padding: EdgeInsets.only(left: 14.w, right: 8.w, top: 9.h),
              child: Container(
                height: 300.0.h, // Adjust height as needed
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 1.0),
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
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("הסטטוס פורסם בהצלחה!",
                                style: AppConstantsTextStyle.heading2Style),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
            ConstantLargeButton(
              text: "בוצע",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                      (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
