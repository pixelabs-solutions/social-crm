import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/ApiConstants.dart';
import 'package:social_crm/utilis/Toast.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/auth/forgotpassword_screen.dart';
import 'package:social_crm/view/auth/whatsapp_code.dart';
import 'package:social_crm/view/screens/navigaton_main.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:http/http.dart' as http;

import 'confirmationScreen.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
                prefixText: '+',
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
        isLoading
            ? const CircularProgressIndicator(
                color: AppColors.orangeButtonColor,
              ) // Show circular progress indicator when loading
            : ConstantLargeButton(
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

    setState(() {
      isLoading = true; // Start loading indicator
    });

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
      print('Response status code: ${response.body}');
      if (response.statusCode == 200) {
        print('Login successful');
        print('Response data: ${response.body}');

        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['data']['token'];
        final whatsappCode = jsonResponse['data']['user']['whatsapp_code'];
        final userID = jsonResponse['data']['user']['id'];
        final isApproved = jsonResponse['data']['user']['is_approved'];
        print('++++++++++++++${whatsappCode}+++++++++++++++');
        print('+++++++++++userID+++${userID}+++++++++++++++');

        // Navigate to the appropriate screen based on WhatsApp code and isApproved
        if (whatsappCode != null && whatsappCode.isNotEmpty) {
          await saveToken(token, userID, whatsappCode ?? '',isApproved );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WhatsAppCode(isApproved: isApproved)),
          );
        } else if (isApproved == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationSuccess()),
          );
        } else if (isApproved == 1) {
          await saveToken(token, userID, whatsappCode ?? '',isApproved);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }

        ToastUtil.showToast(
          msg: "Login successful",
          backgroundColor: Colors.green,
        );
      } else {
        print('Failed to log in');
        print('Response code: ${response.statusCode}');
        print('Response data: ${response.body}');

        final jsonResponse = jsonDecode(response.body);
        final errorMessage = jsonResponse['message'];

        // Show error SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text(errorMessage)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading indicator
      });
    }
  }



  Future<void> saveToken(String token, int userID, String whatsappCode, int isApproved) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('userID', userID);
    await prefs.setString('whatsappCode', whatsappCode);
    await prefs.setInt('isApproved', isApproved);

    // Print statements to verify saved values
    print('Token saved to SharedPreferences: $token');
    print('UserID saved to SharedPreferences: $userID');
    print('WhatsApp code saved to SharedPreferences: $whatsappCode');

    // Retrieve and print the saved values to ensure they were saved correctly
    String? savedToken = prefs.getString('token');
    int? savedUserID = prefs.getInt('userID');
    String? savedWhatsAppCode = prefs.getString('whatsappCode');

    print('Retrieved from SharedPreferences - Token: $savedToken');
    print('Retrieved from SharedPreferences - UserID: $savedUserID');
    print('Retrieved from SharedPreferences - WhatsApp Code: $savedWhatsAppCode');
  }

}
