import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/ApiConstants.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/auth/forgotpassword_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import 'package:http/http.dart' as http;

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
            showText('מספר טלפון'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomTextField(
                controller: phoneController,
                height: MediaQuery.of(context).size.height * 0.06,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 5.h),
            showText('סיסמה'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomPasswordTextField(
                controller: passwordController,
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        ConstantLargeButton(
          text: 'כניסה לאפליקציה ->',
          onPressed: () async {
            await loginUser(context);
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
                  'שכחת סיסמה?',
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: AppConstantsTextStyle.kNormalWhiteTextStyle,
        ),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    final String apiUrl = ApiEndPointsConstants.loginApiUrl;
    final String phone = phoneController.text;
    final String password = passwordController.text;

    try {

      final requestBody = jsonEncode(<String, String>{
        'phone_number': phone,
        'password': password,
      });

      print('Sending request to $apiUrl');
      print('Request body: $requestBody');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );
      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Login successful');
        print('Response data: ${response.body}');

        // Save token to SharedPreferences
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['data']['token'];
        await saveToken(token);

        // Navigate to main screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );

        // Show success toast
        Fluttertoast.showToast(
          msg: 'Login successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Failed to log in');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');

        // Show error toast
        Fluttertoast.showToast(
          msg: 'Failed to log in',
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
        msg: 'Error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved to SharedPreferences: $token');
  }

}
