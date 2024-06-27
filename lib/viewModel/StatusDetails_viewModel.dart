// viewmodels/status_history_viewmodel.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/StatusDetail_Model.dart';


class StatusHistoryViewModel extends ChangeNotifier {
  List<StatusHistoryModel> _statusHistory = [];
  bool _isLoading = false;

  List<StatusHistoryModel> get statusHistory => _statusHistory;
  bool get isLoading => _isLoading;

  Future<void> fetchStatusHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _statusHistory = data.map((json) => StatusHistoryModel.fromJson(json)).toList();
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
