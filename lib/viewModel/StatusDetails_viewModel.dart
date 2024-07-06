import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'package:social_crm/utilis/ApiConstants.dart';
import '../Model/statusDetails.dart';

class StatusHistoryViewModel extends ChangeNotifier {
  List<Status> _statusHistory = [];
  bool _isLoading = false;

  List<Status> get statusHistory => _statusHistory;
  bool get isLoading => _isLoading;

  Future<void> fetchStatusHistory() async {
    final String apiUrl = ApiEndPointsConstants.FetchStatus;
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle case where token is not found (optional)
        print('Token not found in SharedPreferences');
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Set headers with token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      print("Response Code of Status API from Tab: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        StatusResponse statusResponse = StatusResponse.fromJson(responseData);
        print('Response Data: $responseData');
        _statusHistory = statusResponse.data.statuses;
      } else {
        // Handle error
        print('Failed to load status history: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Exception occurred while fetching status history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
