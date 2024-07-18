import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/ApiConstants.dart';
import '../Model/statusDetails.dart';
import '../Model/statuslist.dart';

class StatusHistoryViewModel extends ChangeNotifier {
  List<Statuses> _statusHistory = [];
  bool _isLoading = false;

  List<Statuses> get statusHistory => _statusHistory;
  bool get isLoading => _isLoading;

  Future<void> fetchStatusHistory() async {
    Dio dio = Dio();
    _isLoading = true;
    notifyListeners();
    DateTime now = DateTime.now().toUtc();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc());

    print('Current Date: $currentDate');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await dio.get(
        "https://scrm-apis.woo-management.com/api/status/list",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          "start_date": currentDate,
          "posted": 1,
          "end_date": currentDate,
        },
      );

      print("Response from 24 hours API: ${response.data}");

      if (response.statusCode == 200) {
        final statusList = StatusList.fromJson(response.data);
        _statusHistory = statusList.data?.statuses ?? [];
      } else {
        throw Exception('Failed to load status history');
      }
    } catch (e) {
      print('Error fetching status history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

