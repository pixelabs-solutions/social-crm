import 'dart:async';
import 'dart:convert';

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:social_crm/utilis/ApiConstants.dart';
import 'package:social_crm/utilis/variables.dart';
import '../Model/status.dart';
import '../Model/statuslist.dart';
import '../utilis/shared_prefes.dart';
import '../view/screens/publishSuccesScreen.dart';
import 'package:path/path.dart' as path;

class TextStatusViewModel extends ChangeNotifier {
  StatusData _textStatus = StatusData(text: '', backgroundColorHex: '#FFFFFF');
  StatusData get textStatus => _textStatus;

  StatusList? _statusList;
  StatusList? get statusList => _statusList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextStatusViewModel() {
    getAllStatus();
  }

  void setText(String text) {
    _textStatus = StatusData(
        text: text, backgroundColorHex: _textStatus.backgroundColorHex);
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    String colorHex = '#${color.value.toRadixString(16).substring(2)}';
    _textStatus =
        StatusData(text: _textStatus.text, backgroundColorHex: colorHex);
    notifyListeners();
  }

  //** Post-Text */
  Future<void> postTextStatus(BuildContext context, String? bgcolor,
      String? caption, String? date, String? time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      _isLoading = true;
      notifyListeners();

      final request = jsonEncode({
        "type": "text",
        "content": {
          "background_color": bgcolor,
          "caption_color": "#000000",
          "font_type": "Arial",
          "caption": caption
        },
        "schedule_date": date?.substring(0, 10),
        "schedule_time": time?.substring(11, 19)
      });

      final response = await http.post(
          Uri.parse('${ApiEndPointsConstants.baseUrl}/status/create'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: request);

      if (response.statusCode == 201) {
        //*** Chnge this route */
        Navigator.push(
          context,
          MaterialPageRoute(builder: (i) => const PublishSuccess()),
        );
        Fluttertoast.showToast(
          msg: 'Status Uploaded Sucessfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Uploading Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //** Post-Image */

  Future<void> postImageStatus(
      BuildContext context, String? caption, String? date, String? time) async {
    _isLoading = true;
    notifyListeners();
    var token = SharedPrefernce.prefs?.getString('token');
    var formData = dio.FormData();

    // Add non-null values to the FormData
    formData.fields.addAll([
      const MapEntry('type', 'image'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? ''), // Add caption to content
    ]);

    List<File> files = Variables.selectedImages;

    if (files.isNotEmpty) {
      for (var i = 0; i < files.length; i++) {
        String contentType = '.png'; // Default content type, change as needed

        if (files[i].path.endsWith('.jpg') || files[i].path.endsWith('.jpeg')) {
          contentType = 'jpeg';
        } else if (files[i].path.endsWith('.png')) {
          contentType = 'png';
        }

        formData.files.add(MapEntry(
          'content[images][$i]',
          await dio.MultipartFile.fromFile(
            files[i].path,
            filename: files[i].path.split('/').last,
            contentType: MediaType('application', contentType),
          ),
        ));
      }
    }

    try {
      final response = await dio.Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/create', // Replace with your API endpoint
        options: dio.Options(
          headers: {
            'Authorization':
                'Bearer $token', // Replace $token with your actual token
          },
        ),
        data: formData,
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (i) => const PublishSuccess()),
        );
        Fluttertoast.showToast(
          msg: 'Status Uploaded Sucessfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Variables.selectedImages.clear();
      } else {
        Fluttertoast.showToast(
          msg: 'Uploading Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      // Handle success
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //** Post-Video */

  Future<void> postVideoStatus(
      BuildContext context, String? caption, String? date, String? time) async {
    _isLoading = true;
    notifyListeners();
    var token = SharedPrefernce.prefs?.getString('token');
    var formData = dio.FormData();

    // Add non-null values to the FormData
    formData.fields.addAll([
      const MapEntry('type', 'video'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? ''), // Add caption to content
    ]);

    List<File> files = Variables.selectedImages;

    if (files.isNotEmpty) {
      for (var i = 0; i < files.length; i++) {
        String contentType = '.mp4'; // Default content type, change as needed

        formData.files.add(MapEntry(
          'content[videos][$i]',
          await dio.MultipartFile.fromFile(
            files[i].path,
            filename: files[i].path.split('/').last,
            contentType: MediaType('application', contentType),
          ),
        ));
      }
    }

    try {
      final response = await dio.Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/create', // Replace with your API endpoint
        options: dio.Options(
          headers: {
            'Authorization':
                'Bearer $token', // Replace $token with your actual token
          },
        ),
        data: formData,
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (i) => const PublishSuccess()),
        );
        Fluttertoast.showToast(
          msg: 'Status Uploaded Sucessfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Variables.selectedImages.clear();
      } else {
        Fluttertoast.showToast(
          msg: 'Uploading Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      // Handle success
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///** Edit-Status */

  Future<void> getAllStatus() async {
    Dio dio = Dio();
    var token = SharedPrefernce.prefs?.getString('token');
    _isLoading = true;
    notifyListeners();
    try {
      final response = await dio.get(
        "https://scrm-apis.woo-management.com/api/status/list",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        _statusList = StatusList.fromJson(response.data);
        log("${_statusList?.data?.statuses?.length}");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
