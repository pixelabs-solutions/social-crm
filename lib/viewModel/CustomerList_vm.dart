// viewmodels/customer_viewmodel.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customer.dart';

class CustomerViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final MultiSelectController controller = MultiSelectController();

  bool _isLoading = false;
  List<Customer> _customers = [];
  List<ValueItem> selectedItems = [];

  bool get isLoading => _isLoading;
  List<Customer> get customers => _customers;

  final List<ValueItem> _items = [
    const ValueItem(label: 'איפור', value: 'makeup'),
    const ValueItem(label: 'מספרת שיער', value: 'hair_cuter'),
    // Add more items as needed
  ];

  List<ValueItem> get items => _items;

  CustomerViewModel() {
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('https://scrm-apis.woo-management.com/api/customer/list'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _customers = data.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (error) {
      print('Error fetching customers: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCustomer() async {
    if (!validateForm()) return;

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(token);

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('https://scrm-apis.woo-management.com/api/customer/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': mailController.text,
          'occupation': selectedItems.map((item) => item.value).toList(),
        }),
      );

      // Log the request and response details for debugging
      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        fetchCustomers(); // Refresh the customer list
        clearForm();
      } else {
        throw Exception('Failed to add customer');
      }
    } catch (error) {
      print('Error adding customer: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> editCustomer() async {
    if (!validateForm()) return;

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('https://scrm-apis.woo-management.com/api/customer/edit'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': mailController.text,
          'occupation': selectedItems.map((item) => item.value).toList(),
        }),
      );

      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Handle successful edit (if needed)
      } else {
        throw Exception('Failed to edit customer: ${response.statusCode}');
      }
    } catch (error) {
      print('Error editing customer: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool validateForm() {
    bool isValid = true;

    if (nameController.text.isEmpty) {
      isValid = false;
    }
    if (mailController.text.isEmpty) {
      isValid = false;
    }
    if (phoneController.text.isEmpty) {
      isValid = false;
    }
    if (selectedItems.isEmpty) {
      isValid = false;
    }

    notifyListeners(); // Notify listeners once after checking all fields

    return isValid;
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    mailController.clear();
    selectedItems.clear();
  }
}
