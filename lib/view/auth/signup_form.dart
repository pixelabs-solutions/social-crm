import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utilis/ApiConstants.dart';
import '../../utilis/Toast.dart';
import '../../utilis/constant_colors.dart';
import '../screens/first_screen.dart';

class SignUpForm extends StatefulWidget {

  SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController retryPassword = TextEditingController();
  bool isLoading = false;

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
          buildPhoneFormField(context, "מספר טלפון", phoneController, TextInputType.number),
          buildFormField(context, "סיסמה", passwordController, TextInputType.visiblePassword, isPassword: true),
          buildFormField(context, "חזור על הסיסמה", retryPassword, TextInputType.visiblePassword, isPassword: true),

          buildFormField(
              context, "שם פרטי", firstNameController, TextInputType.text),
          buildFormField(
              context, "שם משפחה", lastNameController, TextInputType.text),
          buildFormField(context, "כתובת מייל", emailController,
              TextInputType.emailAddress),
          buildFormField(
              context, "מספר טלפון", phoneController, TextInputType.number),
          buildFormField(context, "סיסמה", passwordController,
              TextInputType.visiblePassword,
              isPassword: true),
          buildFormField(context, "חזור על הסיסמה", retryPassword,
              TextInputType.visiblePassword,
              isPassword: true),

          SizedBox(height: 40.h),
          isLoading
              ? Center(
                child: CircularProgressIndicator(
                            color: AppColors.orangeButtonColor,
                          ),
              ) // Show circular progress indicator when loading
              : ConstantLargeButton(
            text: 'כניסה לאפליקציה ->',
            onPressed: () async {
              await registerUser(context);
            },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget buildFormField(BuildContext context, String labelText,
      TextEditingController controller, TextInputType keyboardType,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2),
          child: Text(
            labelText,
            style: AppConstantsTextStyle.kNormalWhiteTextStyle,
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: isPassword
              ? CustomPasswordTextField(controller: controller)

              : CustomTextFields(
            controller: controller,
            height: MediaQuery.of(context).size.height * 0.06,
            keyboardType: keyboardType, textDirection: TextDirection.rtl,
          ),

        ),
      ],
    );
  }

  Widget buildPhoneFormField(BuildContext context, String labelText, TextEditingController controller, TextInputType keyboardType) {
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
          child: CustomTextField(
            controller: controller,
            height: MediaQuery.of(context).size.height * 0.06,
            keyboardType: keyboardType,
            textDirection: TextDirection.rtl,
            prefixText: '+', // Prefix text added here
          ),
        ),
      ],
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final String apiUrl = ApiEndPointsConstants.RegisterApiUrl;
    final String phone = '+${phoneController.text}'; // Include prefix here
    final String password = passwordController.text;
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String confirmPassword = retryPassword.text;

    setState(() {
      isLoading = true; // Start loading indicator
    });

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

      if (response.statusCode == 201) {
        print('Registration successful');
        print('Response data: ${response.body}');

        ToastUtil.showToast(msg: "Register successful", backgroundColor: Colors.green);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (i) => AuthScreen()));
      } else {
        // Registration failed, handle error message from API
        final jsonResponse = json.decode(response.body);
        final errorMessage = _extractErrorMessage(jsonResponse);
        ToastUtil.showToast(msg: errorMessage, backgroundColor: Colors.red);



        print('Failed to register');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
      ToastUtil.showToast(msg: "Error occurred", backgroundColor: Colors.red);
    }finally {
      setState(() {
        isLoading = false; // Stop loading indicator
      });
    }
  }

  String _extractErrorMessage(Map<String, dynamic> jsonResponse) {
    // Extract error message from response JSON
    final message = jsonResponse['message'];
    if (message is Map<String, dynamic>) {
      final List<dynamic> errors = message.values.first;
      if (errors.isNotEmpty) {
        return errors.first.toString(); // Return the first error message
      }
    }
    return 'Registration failed'; // Default message if parsing fails
  }

}
