import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/ApiConstants.dart';
import 'package:social_crm/utilis/Toast.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:http/http.dart' as http;
import '../screens/NavigatonMain.dart';

class WhatsAppCode extends StatefulWidget {
  const WhatsAppCode({Key? key}) : super(key: key);

  @override
  State<WhatsAppCode> createState() => _WhatsAppCodeState();
}

class _WhatsAppCodeState extends State<WhatsAppCode> {
  String? whatsAppCode;

  @override
  void initState() {
    super.initState();
    _loadWhatsAppCode();
  }
  void _copyCode() {
    if (whatsAppCode != null) {
      Clipboard.setData(ClipboardData(text: whatsAppCode!));
      ToastUtil.showToast(msg: "Code Copied Successfully",
      backgroundColor: Colors.green
      );
    }
  }

  Future<void> _loadWhatsAppCode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      whatsAppCode = prefs.getString('whatsAppCode');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            SizedBox(height: 10.0.h),
            Padding(
              padding:  EdgeInsets.only(left: 14.w, right: 8.w, top: 15.h),
              child: Container(
                height: 250.0.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(height: 15.h,),
                      Container(
                      
                        decoration: BoxDecoration(
                          color: AppColors.orangeButtonColor,
                          borderRadius: BorderRadius.circular(12)

                        ),

                          child: Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 16.h),
                            child: SvgPicture.asset("assets/faWhatsapp.svg",

                              height: 60.h,
                              color: AppColors.primaryColor,

                            ),
                          )),
                      SizedBox(height: 20.h,),
                      Text( whatsAppCode!,
                      style: TextStyle(
                        color: AppColors.orangeButtonColor, fontSize: 20.sp,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      SizedBox(height: 20.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(
                           horizontal: 14.w,
                           vertical: 8.0.h),
                       child: ConstantLargeButton(text: "Copy Code",
                           onPressed: (){
                         _copyCode();
                           }),
                     )
                    ],
                  )
                ),
              ),

            ),
            SizedBox(height: 20.0.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:16.0.w),
              child: ConstantLargeButton(text: "Next",
                  onPressed: (){
                    fetchData();
                  }
              ),
            )


          ],
        ),
      ),
    );
  }
  Future<void> fetchData() async {
    final String apiUrl = ApiEndPointsConstants.GetUserProfile; // Replace with your API URL
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Handle successful response
        final jsonResponse = jsonDecode(response.body);
        print('Response body: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        // Handle error response
        print('Response body: ${response.body}');
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'error') {
         ToastUtil.showToast(msg: "Please authenticate first to login",
           backgroundColor: Colors.red
         );
        } else {
          ToastUtil.showToast(msg: "Failed to fetch data");
        }
      }
    } catch (e) {
      // Handle exception
      print('Error occurred: $e');
      ToastUtil.showToast(msg: "Error occurred: $e");
    }
  }




}
