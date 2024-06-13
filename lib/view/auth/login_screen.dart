import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/auth/forgotpassword_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            showText('Phone Number'),
            CustomTextField(
              controller: phoneController,
              height: MediaQuery.of(context).size.height * 0.06,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 5.h),
            showText('Password'),
            CustomPasswordTextField(
              controller: passwordController,
            ),
          ],
        ),
        SizedBox(height: 40.h),
        ConstantLargeButton(
          text: 'Login to the app ->',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const MainScreen()));
          },
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordForm()));
                },
                child: Text(
                  'forgot Password?',
                  style: AppConstantsTextStyle.kDefaultappTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
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
