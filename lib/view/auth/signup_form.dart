import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController retryPassword = TextEditingController();

  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 5.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            showText("First name and Last name"),
            CustomTextField(
              controller: nameController,
              height: MediaQuery.of(context).size.height * 0.06,
              keyboardType: TextInputType.number,
            ),
            showText("mail adress"),
            CustomTextField(
              controller: emailController,
              height: MediaQuery.of(context).size.height * 0.06,
              keyboardType: TextInputType.number,
            ),
            showText("Phone Number"),
            CustomTextField(
              controller: phoneController,
              height: MediaQuery.of(context).size.height * 0.06,
              keyboardType: TextInputType.number,
            ),
            showText("Password"),
            CustomPasswordTextField(
              controller: passwordController,
            ),
            showText('Retry the password'),
            CustomPasswordTextField(
              controller: retryPassword,
            ),
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        ConstantLargeButton(
          text: 'Register to the app ->',
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
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
