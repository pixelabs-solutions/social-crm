import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utilis/ApiConstants.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController retryPassword = TextEditingController();

  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5.h),
          buildFormField(context, "שם פרטי", firstNameController, TextInputType.text),
          buildFormField(context, "שם משפחה", lastNameController, TextInputType.text),
          buildFormField(context, "כתובת מייל", emailController, TextInputType.emailAddress),
          buildFormField(context, "מספר טלפון", phoneController, TextInputType.number),
          buildFormField(context, "סיסמה", passwordController, TextInputType.visiblePassword, isPassword: true),
          buildFormField(context, "חזור על הסיסמה", retryPassword, TextInputType.visiblePassword, isPassword: true),
          SizedBox(height: 40.h),
          ConstantLargeButton(
            text: 'הרשמה לאפליקציה ->',
            onPressed: () async {
              await registerUser(context);
            },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget buildFormField(BuildContext context, String labelText, TextEditingController controller, TextInputType keyboardType, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2),
          child: Text(
            labelText,
            style: AppConstantsTextStyle.kNormalWhiteTextStyle,
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: isPassword
              ? CustomPasswordTextField(controller: controller)
              : CustomTextField(
            controller: controller,
            height: MediaQuery.of(context).size.height * 0.06,
            keyboardType: keyboardType, textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final String apiUrl = ApiEndPointsConstants.RegisterApiUrl;
    final String phone = phoneController.text;
    final String password = passwordController.text;
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String confirmPassword = retryPassword.text;

    // Simple validation
    if (password != confirmPassword) {
      print('Passwords do not match');
      return;
    }

    try {
      print('Sending request to $apiUrl');
      print('Request body: ${jsonEncode(<String, String>{
        'phone_number': phone,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      })}');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phone,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
        }),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Registration successful');
        print('Response data: ${response.body}');
        // Navigate to login or main screen after successful registration
      } else {
        print('Failed to register');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
