import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/ApiConstants.dart';

import '../Model/Status.dart';

class DashboardViewModel extends ChangeNotifier {
  StatusDetails? statusDeatils;
  bool isLoading = false;
  int totalCustomers = 0;
  int highestViewers = 0;
  int pendingAds = 0;
  String? scheduleDate;
  String? scheduleTime;
  Future<void> fetchDashboardData() async {
    isLoading = true;
    notifyListeners();
    await fetchPendingStatusCount();
    await fetchUpcomingStatus();
    await fetchTotalCustomers();
    await fetchHighestViewers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUpcomingStatus() async {
    const String apiUrl =
        'https://scrm-apis.woo-management.com/api/status/list';

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
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      var request = http.Request('GET', Uri.parse(apiUrl));
      request.body = json.encode({
        "posted": 0,
        "start_date": formattedDate,
      });
      request.headers.addAll(headers);

      isLoading = true;
      notifyListeners();

      final http.StreamedResponse response = await request.send();
      print("Response From Upcoming Status Api: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(jsonResponse);
        print(parsedResponse);

        final data = parsedResponse['data'];
        if (data != null) {
          final statuses = data['statuses'];
          if (statuses != null && statuses.isNotEmpty) {
            final status = statuses[0];
            statusDeatils = StatusDetails.fromJson(status);
            scheduleDate = status['schedule_date'];
            scheduleTime = status['schedule_time'];
          }
        }
      } else {
        print('Failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingStatusCount() async {
    const String apiUrl = 'https://scrm-apis.woo-management.com/api/status/list';

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

      var request = http.Request('GET', Uri.parse(apiUrl));
      request.body = json.encode({
        "posted": 0,
      });
      request.headers.addAll(headers);

      isLoading = true;
      notifyListeners();

      final http.StreamedResponse response = await request.send();
      print("Response From Pending Status List API: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(jsonResponse);
        print(parsedResponse);

        final data = parsedResponse['data'];
        if (data != null) {
          final count = data['count'] ?? 0;
          pendingAds = count;
        }
      } else {
        print('Failed: ${response.reasonPhrase}');
        pendingAds = 0;
      }
    } catch (e) {
      print('Error occurred: $e');
      pendingAds = 0;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchTotalCustomers() async {
    final String apiUrl = ApiEndPointsConstants.CountCustomers;

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

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );
      print("Response Code of Customers  Count APi: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final total = jsonResponse['data']['count'] ?? 0;
        print(jsonResponse);
        totalCustomers = total;
      } else {
        print('Failed: ${response.reasonPhrase}');
        totalCustomers = 0;
      }
    } catch (e) {
      print('Error occurred: $e');
      totalCustomers = 0;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchHighestViewers() async {
    const String apiUrl =
        'https://scrm-apis.woo-management.com/api/status/highest-views';

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

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );
      print("Response Code of Highest Views Api${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        highestViewers = jsonResponse['data'] ?? 0;
        print("Response body of Views Api : ${response.body}");
      } else {
        print('Failed: ${response.reasonPhrase}');
        highestViewers = 0;
      }
    } catch (e) {
      print('Error occurred: $e');
      highestViewers = 0;
    } finally {
      notifyListeners();
    }
  }
}
