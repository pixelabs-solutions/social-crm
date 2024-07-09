

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:resize/resize.dart';

import 'package:social_crm/utilis/constant_colors.dart';


class RegistrationSuccess extends StatefulWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccess> createState() => _RegistrationSuccessState();
}

class _RegistrationSuccessState extends State<RegistrationSuccess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/logo.png"),
            SizedBox(height: 10.0.h),
            Padding(
              padding: EdgeInsets.only(left: 14.w, right: 8.w, top: 15.h),
              child: Container(
                height: 250.0.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.h,),
                      Container(
                          decoration: BoxDecoration(
                              color: AppColors.orangeButtonColor,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 16.h
                            ),
                            child: Icon(
                              Icons.check_circle_outlined,
                              size: 50,
                              color: AppColors.primaryColor,
                            ),
                          )
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        "! פרטי ההרשמה נשלחו בהצלחה ",
                        style: TextStyle(
                            color: AppColors.orangeButtonColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        "נחזור אליך בקרוב",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.orangeButtonColor,
                            backgroundColor: AppColors.primaryColor
                        ),
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/faWhatsapp.svg",
                          height: 15.h,
                          color: AppColors.orangeButtonColor,
                        ),
                        label: Text("שלח הודעה")
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangeButtonColor,
                            foregroundColor: AppColors.primaryColor
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.call),
                        label: Text("התקשר אלינו")
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
