import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_images.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/auth/signup_form.dart';
import 'package:social_crm/view/widgets/cunstom_smallbutton.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;

  void toggleForm(bool isLogin) {
    setState(() {
      showLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    MyAppImages.logo,
                    height: 160.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstantSmallButton(
                      text: 'הרשמה',
                      isSelected: !showLogin,
                      onPressed: () {
                        toggleForm(false);
                      },
                    ),
                    SizedBox(width: 20.h),
                    ConstantSmallButton(
                      text: 'כניסה',
                      isSelected: showLogin,
                      onPressed: () {
                        toggleForm(true);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                showLogin ? LoginForm() : SignUpForm(),
                SizedBox(height: 40.h),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Text(
                        'איפיון עיצוב ופיתוח',
                        style: AppConstantsTextStyle.kDefaultappTextStyle,
                      ),
                      Text(
                        "אליהו מלכה",
                        style: AppConstantsTextStyle.kDefaultappTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
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
