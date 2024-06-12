import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_images.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/cunstom_smallbutton.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(),
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
                    showText(
                        'Phone number with which you registered in the system'),
                    CustomTextField(
                      controller: phoneController,
                      height: MediaQuery.of(context).size.height * 0.06,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                ConstantLargeButton(
                  text: 'Send me a verification code',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificationCodeForm()));
                  },
                ),
                SizedBox(
                  height: 140.h,
                ),
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
  final TextEditingController codeController = TextEditingController();

  VerificationCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    showText('Please enter the code sent to you'),
                    CustomTextField(
                      controller: codeController,
                      height: MediaQuery.of(context).size.height * 0.06,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                ConstantLargeButton(
                  text: 'Verify the code →',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPasswordForm()));
                  },
                ),
                SizedBox(
                  height: 140.h,
                ),
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
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retryPassword = TextEditingController();

  NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  text: 'Saving and entering the application',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DialougeSCreen()));
                  },
                ),
                SizedBox(height: 100.h),
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
    return Scaffold(
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
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: AppColors.orangeButtonColor,
                        borderRadius: BorderRadius.circular(25)),
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
                  const Text("The details have been sent successfully!"),
                  const Text(
                      "We will get back to you soon with all the details!")
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
                  text: 'Message us',
                  onPressed: () {},
                  buttonColor: AppColors.orangeButtonColor,
                ),
                CustomSmallButton(
                  icon: MyAppImages.phoneIcon,
                  text: 'Call us',
                  onPressed: () {},
                  buttonColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 60.h),
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
    );
  }
}
