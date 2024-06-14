import 'package:flutter/material.dart';
import 'package:resize/resize.dart' ;
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_images.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/auth/signup_form.dart';
import 'package:social_crm/view/widgets/cunstom_smallbutton.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                      text: 'Enrollment',
                      isSelected: !showLogin,
                      onPressed: () {
                        toggleForm(false);
                      },
                    ),
                    SizedBox(width: 20.h),
                    ConstantSmallButton(
                      text: 'Entrance',
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
                Text('Characterization design and development',
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
      ),
    );
  }
}
