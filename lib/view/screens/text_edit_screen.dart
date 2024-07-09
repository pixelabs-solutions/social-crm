import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/Model/status.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/statuslist.dart';
import '../../utilis/ApiConstants.dart';
import '../../utilis/Toast.dart';


import '../../viewModel/customerList_vm.dart';
import 'calendar_screen.dart';


class TextEditScreen extends StatefulWidget {
  const TextEditScreen({super.key, required this.statusData});
  final Statuses statusData;

  @override
  State<TextEditScreen> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends State<TextEditScreen> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 13.w),
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Text(
                            'Text Status Schedule',
                            style: AppConstantsTextStyle.heading2Style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              padding: EdgeInsets.only(top: 12.0.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.h),
                    _customIconRow("assets/deleteIcon.svg", "text: טקסט",
                        onTap: () {
                          showDeleteDialog(context, widget.statusData.statusIds!);
                        }),

                    SizedBox(height: 10.h),
                    Container(
                      height: 200.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          color: hexToColor(getTextFromJson(
                              widget.statusData.content)['background_color']),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          getTextFromJson(widget.statusData.content)['caption'],
                          style: TextStyle(
                            color: hexToColor(getTextFromJson(
                                widget.statusData.content)['caption_color']),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ConstantLargeButton(
                        text: "Change",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (i) => CalendarScreen(
                                      statusData: StatusData(
                                          statusId: widget.statusData.id,
                                          text: getTextFromJson(
                                              widget.statusData.content)['caption'],
                                          contentType: "text",
                                          isEditApi: true,
                                          backgroundColorHex: getTextFromJson(
                                              widget.statusData.content)[
                                          'background_color']))));
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> getTextFromJson(String? jsonString) {
    return jsonDecode(jsonString!);
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  void showDeleteDialog(BuildContext context, String statusID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('אישור מחיקה'),
          content: const Text('האם אתה בטוח שברצונך למחוק את הלקוח?'),
          actions: <Widget>[
            TextButton(
              child: const Text('ביטול'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('מחק'),
              onPressed: () {
                deleteStatus(statusID).then((_) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Navigate back to previous screen
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _customIconRow(String icon, String text, {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h),
            child: Text(
              text,
              style: AppConstantsTextStyle.kNormalWhiteTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteStatus(String statusId) async {
    String deleteStatusApiUrl = '${ApiEndPointsConstants.DeleteSatus}/$statusId';
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.options.headers['Content-Type'] = 'application/json';

      final response = await dio.delete(deleteStatusApiUrl);

      print('Request: ${response.requestOptions}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.data}');

      if (response.statusCode == 200) {
        ToastUtil.showToast(
          msg: 'סטטוס נמחק בהצלחה',
          backgroundColor: Colors.green,
        );
      } else {
        throw Exception('Failed to delete status');
      }
    } catch (error) {
      print('Error deleting status: $error');
      ToastUtil.showToast(
        msg: 'שגיאה במחיקת סטטוס',
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
