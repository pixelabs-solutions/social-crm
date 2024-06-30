import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_images.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/cunstom_smallbutton.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import 'package:http/http.dart' as http;

import '../../utilis/Toast.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  ForgotPasswordForm({super.key});

  Future<void> forgotPassword(BuildContext context) async {
    const String apiUrl =
        'https://scrm-apis.woo-management.com/api/auth/forgot-password';
    final String phone = phoneController.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phone,
        }),
      );

      if (response.statusCode == 200) {
        print('Forgot password request successful');
        print('Response data: ${response.body}');

        // Show success toast
        Fluttertoast.showToast(
          msg: 'קוד האימות נשלח בהצלחה',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Navigate to verification code screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCodeForm(
                    phoneNumber: phone,
                  )),
        );
      } else {
        print('Failed to request forgot password');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');

        // Show error toast
        Fluttertoast.showToast(
          msg: 'שגיאה בשליחת קוד אימות',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Error occurred: $e');

      // Show error toast
      Fluttertoast.showToast(
        msg: 'שגיאה: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.all(14.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      MyAppImages.logo,
                      height: 160.h,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      showText('מספר טלפון שאיתו נרשמת במערכת'),
                      CustomTextField(
                        controller: phoneController,
                        height: MediaQuery.of(context).size.height * 0.06,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  ConstantLargeButton(
                    text: 'שלח לי קוד אימות',
                    onPressed: () async {
                      await forgotPassword(context);
                    },
                  ),
                  SizedBox(
                    height: 140.h,
                  ),
                  Text('עיצוב ופיתוח: עליהו מלכא',
                      style: AppConstantsTextStyle.kDefaultappTextStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalWhiteTextStyle,
      ),
    );
  }
}

class VerificationCodeForm extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController codeController = TextEditingController();

  VerificationCodeForm({required this.phoneNumber, super.key});

  Future<void> verifyOtp(BuildContext context) async {
    const String apiUrl =
        'https://scrm-apis.woo-management.com/api/auth/verify-otp';
    final String code = codeController.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phoneNumber,
          'otp': code,
        }),
      );

      if (response.statusCode == 200) {
        print('OTP verification successful');
        print('Response data: ${response.body}');

        // Show success toast
        Fluttertoast.showToast(
          msg: 'אימות קוד הצליח',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Navigate to new password screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewPasswordForm(
                    phoneNumber: phoneNumber,
                    otp: code,
                  )),
        );
      } else {
        print('Failed to verify OTP');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');

        // Show error toast
        Fluttertoast.showToast(
          msg: 'שגיאה באימות הקוד',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Error occurred: $e');

      // Show error toast
      Fluttertoast.showToast(
        msg: 'שגיאה: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.all(14.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      MyAppImages.logo,
                      height: 160.h,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      showText('אנא הכנס את הקוד שנשלח אליך'),
                      CustomTextField(
                        controller: codeController,
                        height: MediaQuery.of(context).size.height * 0.06,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  ConstantLargeButton(
                    text: 'אמת את הקוד →',
                    onPressed: () async {
                      await verifyOtp(context);
                    },
                  ),
                  SizedBox(
                    height: 140.h,
                  ),
                  Text('עיצוב ופיתוח: עליהו מלכא',
                      style: AppConstantsTextStyle.kDefaultappTextStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalWhiteTextStyle,
      ),
    );
  }
}

class NewPasswordForm extends StatelessWidget {
  final String phoneNumber; // Phone number from previous screen
  final String otp;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retryPasswordController = TextEditingController();

  NewPasswordForm({
    required this.phoneNumber,
    required this.otp,
    super.key,
  });

  Future<void> setPassword(BuildContext context) async {
    const String apiUrl =
        'https://scrm-apis.woo-management.com/api/auth/reset-password';
    final String newPassword = passwordController.text;
    final String retryPassword = retryPasswordController.text;

    if (newPassword != retryPassword) {
      ToastUtil.showToast(
        msg: 'הסיסמאות אינן תואמות',
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phoneNumber,
          'otp': otp,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        print('Password set successfully');
        print('Response data: ${response.body}');

        // Show success toast
        ToastUtil.showToast(
          msg: 'הסיסמה נשמרה בהצלחה',
          backgroundColor: Colors.green,
        );

        // Navigate to dialogue screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DialougeSCreen()),
        );
      } else {
        print('Failed to set password');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');

        // Show error toast
        ToastUtil.showToast(
          msg: 'שגיאה בשמירת הסיסמה',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print('Error occurred: $e');

      // Show error toast
      ToastUtil.showToast(
        msg: 'שגיאה: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(14.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      MyAppImages.logo,
                      height: 160.h,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      showText("סיסמה"),
                      CustomPasswordTextField(
                        controller: passwordController,
                      ),
                      showText('נסה שוב את הסיסמה'),
                      CustomPasswordTextField(
                        controller: retryPasswordController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ConstantLargeButton(
                    text: 'שמירה וכניסה לאפליקציה',
                    onPressed: () {
                      final newPassword = passwordController.text;
                      final retryPassword = retryPasswordController.text;

                      if (newPassword != retryPassword) {
                        ToastUtil.showToast(
                          msg: 'הסיסמאות אינן תואמות',
                          backgroundColor: Colors.red,
                        );
                      } else {
                        setPassword(context);
                      }
                    },
                  ),
                  SizedBox(height: 100.h),
                  Text('עיצוב ופיתוח: עליהו מלכא',
                      style: AppConstantsTextStyle.kDefaultappTextStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalWhiteTextStyle,
      ),
    );
  }
}

class DialougeSCreen extends StatelessWidget {
  const DialougeSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  MyAppImages.logo,
                  height: 160.h,
                ),
              ),
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: AppColors.orangeButtonColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 18,
                          child: Image.asset(
                            MyAppImages.checkIcon,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Text("פרטי הפרטים נשלחו בהצלחה!"),
                    const Text(
                      "נחזור אליך בקרוב עם כל הפרטים!",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSmallButton(
                    icon: MyAppImages.whatsappIcon,
                    text: 'שלח הודעה',
                    onPressed: () {},
                    buttonColor: AppColors.orangeButtonColor,
                  ),
                  CustomSmallButton(
                    icon: MyAppImages.phoneIcon,
                    text: 'התקשר אלינו',
                    onPressed: () {},
                    buttonColor: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              Text('עיצוב ופיתוח: עליהו מלכא',
                  style: AppConstantsTextStyle.kDefaultappTextStyle),
              Text(
                "Eliyahu Malka",
                style: AppConstantsTextStyle.kDefaultappTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
