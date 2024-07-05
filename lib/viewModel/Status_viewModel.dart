import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_crm/utilis/ApiConstants.dart';
import 'package:social_crm/utilis/variables.dart';
import '../Model/status.dart';
import '../Model/statuslist.dart';
import '../Model/video.dart';

import '../utilis/shared_prefes.dart';
import '../view/screens/publish_succes_screen.dart';
import '../view/screens/video_status_step3.dart';

class TextStatusViewModel extends ChangeNotifier {
  StatusData _textStatus = StatusData(text: '', backgroundColorHex: '#FFFFFF');
  StatusData get textStatus => _textStatus;

  StatusList? _statusList;
  StatusList? get statusList => _statusList;

  StatusList? statusSpecificList;
  bool statusIsLoading = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isSpecficLoading = false;

  VideoStatus? videoStatus;

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
    int? userID = prefs.getInt('userID');
    try {
      _isLoading = true;
      notifyListeners();

      final request = jsonEncode({
        "type": "text",
        "content": {
          "background_color": bgcolor,
          "caption_color": "#000000",
          "font_type": "Arial",
          "caption": caption,
          "id": userID
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
    int? userID = SharedPrefernce.prefs?.getInt('userID');
    var formData = FormData();

    formData.fields.addAll([
      const MapEntry('type', 'image'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? 'hello world'),
      MapEntry('user_id', userID.toString()), // Add caption to content
      // Add userID to formData
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
          await MultipartFile.fromFile(
            files[i].path,
            filename: files[i].path.split('/').last,
            contentType: MediaType('application', contentType),
          ),
        ));
      }
    }

    try {
      final response = await Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/create', // Replace with your API endpoint
        options: Options(
          // followRedirects: false,
          // validateStatus: (status) => true,
          headers: {
            'Authorization': 'Bearer $token',
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
          msg: 'Status Uploaded Successfully',
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //** Post-Video */

  Future<void> postVideoforSpilts(
    BuildContext context,
    double selectedDuration,
  ) async {
    _isLoading = true;

    notifyListeners();

    var token = SharedPrefernce.prefs?.getString('token');

    var formData = FormData();
    int durationInSeconds =
        selectedDuration.toInt() != 0 ? selectedDuration.toInt() : 1;
    // Add non-null values to the FormData
    formData.fields.add(
      MapEntry('seconds', "$durationInSeconds"),
    );

    String contentType = 'mp4'; // Default content type, change as needed

    formData.files.add(MapEntry(
      'video',
      await MultipartFile.fromFile(
        Variables.selectedVideo!.path,
        filename: Variables.selectedVideo?.path.split('/').last,
        contentType: MediaType('application', contentType),
      ),
    ));

    try {
      final response = await Dio().post(
        '${ApiEndPointsConstants.baseUrl}/video/cut', // Replace with your API endpoint
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        Variables.selectedVideoUrl.clear();

        var responseData = response.data as Map<String, dynamic>;
        List<dynamic> data = responseData['data'];

        for (var item in data) {
          Variables.selectedVideoUrl.add(item['id']);
        }

        videoStatus = VideoStatus.fromJson(response.data);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (i) => VideoUploadStep3Screen(videoStatus: videoStatus)),
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
      notifyListeners();
      _isLoading = false;
    }
  }

//** Post-Video-Status */
  Future<void> postVideoStatus(
      BuildContext context, String? caption, String? date, String? time) async {
    _isLoading = true;
    notifyListeners();
    var token = SharedPrefernce.prefs?.getString('token');
    int? userID = SharedPrefernce.prefs?.getInt('userID');
    var formData = FormData();

    // Add non-null values to the FormData
    formData.fields.addAll([
      const MapEntry('type', 'video'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? ''),

      MapEntry('user_id', userID.toString()), // Add userID to formData
    ]);

    // Add selected video URLs to FormData
    for (int i = 0; i < Variables.selectedVideoUrl.length; i++) {
      formData.fields
          .add(MapEntry('content[videos][$i]', Variables.selectedVideoUrl[i]));
    }

    try {
      final response = await Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/create', // Replace with your API endpoint
        options: Options(
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
          msg: 'Status Uploaded Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Variables.selectedVideoUrl.clear();
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

  ///** Get_All-Status */

  Future<void> getAllStatus() async {
    Dio dio = Dio();
    var token = SharedPrefernce.prefs?.getString('token');
    statusIsLoading = true;
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
      }
    } finally {
      statusIsLoading = false;
      notifyListeners();
    }
  }

  ///** Get_All-Status */

  Future<void> getSpecficStatus(String dateTime) async {
    Dio dio = Dio();
    var token = SharedPrefernce.prefs?.getString('token');
    isSpecficLoading = true;
    notifyListeners();
    try {
      final response =
          await dio.get("https://scrm-apis.woo-management.com/api/status/list",
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }),
              data: {"start_date": dateTime}
              // "posted": 0,

              // "end_date": "2024-06-29"

              );

      if (response.statusCode == 200) {
        statusSpecificList = StatusList.fromJson(response.data);
      }
    } finally {
      isSpecficLoading = false;
      notifyListeners();
    }
  }

  //** Post-EditText -Status*/
  Future<void> postTextEditStatus(BuildContext context, int? statusId,
      String? bgcolor, String? caption, String? date, String? time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userID = prefs.getInt('userID');
    try {
      _isLoading = true;
      notifyListeners();

      final request = jsonEncode({
        "type": "text",
        "content": {
          "background_color": bgcolor,
          "caption_color": "#000000",
          "font_type": "Arial",
          "caption": caption,
          "id": userID
        },
        "schedule_date": date?.substring(0, 10),
        "schedule_time": time?.substring(11, 19)
      });

      final response = await http.post(
          Uri.parse('${ApiEndPointsConstants.baseUrl}/status/edit/$statusId'),
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
          msg: 'Status Updated Sucessfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Update Failed',
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

  //***Edit-Image-Status */
  Future<void> postImageEditStatus(
      BuildContext context,
      int? statusId,
      String? caption,
      String? date,
      String? time,
      List<String>? imagePaths) async {
    _isLoading = true;
    notifyListeners();
    var token = SharedPrefernce.prefs?.getString('token');
    int? userID = SharedPrefernce.prefs?.getInt('userID');
    var formData = FormData();

    // Add non-null values to the FormData
    formData.fields.addAll([
      const MapEntry('type', 'image'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? ''),

      MapEntry('user_id', userID.toString()), // Add userID to formData
    ]);
    // Add the list of image URLs to the form data
    if (imagePaths != null && imagePaths.isNotEmpty) {
      for (var imageUrl in imagePaths) {
        formData.fields.add(MapEntry('content[images][]', imageUrl));
      }
    }
    try {
      final response = await Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/edit/$statusId', // Replace with your API endpoint
        options: Options(
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
          msg: 'Status Uploaded Successfully',
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

//** Edit-Video-Status */
  Future<void> postEditVideoStatus(
    BuildContext context,
    int? statusId,
    String? caption,
    String? date,
    String? time,
    List<String>? videoPaths,
  ) async {
    _isLoading = true;
    notifyListeners();
    var token = SharedPrefernce.prefs?.getString('token');
    int? userID = SharedPrefernce.prefs?.getInt('userID');
    var formData = FormData();

    // Add non-null values to the FormData
    formData.fields.addAll([
      const MapEntry('type', 'video'),
      MapEntry('schedule_date', date?.substring(0, 10) ?? ''),
      MapEntry('schedule_time', time?.substring(11, 19) ?? ''),
      MapEntry('content[caption]', caption ?? ''), // Add caption to content
      MapEntry('user_id', userID.toString()), // Add userID to formData
    ]);

    if (videoPaths != null && videoPaths.isNotEmpty) {
      for (var imageUrl in videoPaths) {
        formData.fields.add(MapEntry('content[images][]', imageUrl));
      }
    }

    try {
      final response = await Dio().post(
        '${ApiEndPointsConstants.baseUrl}/status/edit/$statusId', // Replace with your API endpoint
        options: Options(
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
          msg: 'Status Updated Successfully',
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
