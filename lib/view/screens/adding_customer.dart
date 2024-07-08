// views/status_history_view.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/Toast.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_singledropdown_button.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import 'package:http/http.dart' as http;

import '../../utilis/ApiConstants.dart';
import '../../viewModel/customerList_vm.dart';

class AddingCustomerDetails extends StatefulWidget {
  const AddingCustomerDetails({super.key});

  @override
  State<AddingCustomerDetails> createState() => _AddingCustomerDetailsState();
}

class _AddingCustomerDetailsState extends State<AddingCustomerDetails> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final MultiSelectController controller = MultiSelectController();

  bool isLoading = false;
  List<ValueItem> selectedItems = [];
  final List<ValueItem> items = [
    const ValueItem(label: 'Influencer', value: 'Influencer'),
    const ValueItem(label: 'Doctor', value: 'Doctor'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                          Icons.arrow_back_ios_outlined, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'הוספת לקוח חדש',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              margin: const EdgeInsets.all(12.0),
              padding: EdgeInsets.only(top: 12.0.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildFormField(
                        context,
                        'שם הלקוח',
                        nameController,
                        TextInputType.name,
                        nameController.text.isEmpty && !isLoading
                            ? 'שדה שם הלקוח הוא חובה'
                            : null,
                      ),
                      _buildFormField(
                        context,
                        'כתובת דואר אלקטרוני',
                        mailController,
                        TextInputType.emailAddress,
                        mailController.text.isEmpty && !isLoading
                            ? 'שדה כתובת הדואר האלקטרוני הוא חובה'
                            : null,
                      ),
                      _buildFormField(
                        context,
                        'מספר טלפון',
                        phoneController,
                        TextInputType.number,
                        phoneController.text.isEmpty && !isLoading
                            ? 'שדה מספר הטלפון הוא חובה'
                            : null,
                      ),
                      showText('תעסוקה'),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: CustomDropdownButton(
                          fieldBackgroundColor: AppColors.kWhiteColor40Opacity,
                          options: items,
                          selectedItem: selectedItems,
                          onOptionSelected: (options) {
                            setState(() {
                              selectedItems = options;
                            });
                          },
                          controller: MultiSelectController(),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      isLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orangeButtonColor,
                        ),
                      ) // Show circular progress indicator when loading
                          : ConstantLargeButton(
                        text: 'הוסף לקוח →',
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await addNewCustomer(
                              context, nameController.text, mailController.text,
                              phoneController.text, selectedItems);
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: AppConstantsTextStyle.kNormalTextWeight800TextStyle,
        ),
      ),
    );
  }

  Widget _buildFormField(BuildContext context,
      String labelText,
      TextEditingController controller,
      TextInputType keyboardType,
      String? errorText,) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showText(labelText),
          CustomTextFields(
            backgroundColor: AppColors.kWhiteColor40Opacity,
            controller: controller,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
            keyboardType: keyboardType,
            textDirection: TextDirection.rtl,
          ),
          if (errorText != null) showErrorText(errorText),
        ],
      ),
    );
  }

  Widget showErrorText(String errorText) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 2.h, bottom: 7.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          errorText,
          style: TextStyle(color: Colors.red, fontSize: 12.sp),
        ),
      ),
    );
  }
  Future<void> addNewCustomer(BuildContext context, String name, String email, String phone, List<ValueItem> selectedItems) async {
    final String apiUrl = ApiEndPointsConstants.CreateCustomers;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Token not found in SharedPreferences');
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var requestBody = {
        "name": name,
        "email": email,
        "phone": phone,
        "occupation": selectedItems.map((item) => item.value).join(',')
      };

      var request = http.Request('POST', Uri.parse(apiUrl));
      request.body = json.encode(requestBody);
      request.headers.addAll(headers);

      // Print the request parameters
      print('Request URL: $apiUrl');
      print('Request Headers: $headers');
      print('Request Body: ${request.body}');

      final http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Print the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 201) {
        print("Customer added successfully");

         ToastUtil.showToast(msg: "Customer Added Succesfully",
         backgroundColor: Colors.green
         );

      } else {
        print('Failed to add customer: ${response.reasonPhrase}');
        showErrorDialog(context, 'Failed to add customer: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred: $e');
      showErrorDialog(context, 'An error occurred: $e');
    }
  }
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
