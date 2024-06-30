// viewmodels/customer_viewmodel.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/customer.dart';
import '../utilis/ApiConstants.dart';
import '../utilis/Toast.dart';

class CustomerViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final MultiSelectController controller = MultiSelectController();

  bool _isLoading = true;
  List<CustomerData> customers = [];
  List<ValueItem> selectedItems = [];

  bool get isLoading => _isLoading;


  List<ValueItem> _items = [
    const ValueItem(label: 'Influencer', value: 'Influencer'),
    const ValueItem(label: 'Doctor', value: 'Doctor'),
    // Add more items as needed
  ];

  List<ValueItem> get items => _items;

  Future<void> fetchCustomers() async {
    final String apiUrl = ApiEndPointsConstants.listCustomers;
    // _isLoading = true;
    // notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }



      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success' && responseData['data'] is List) {
          List<CustomerData> customerList = (responseData['data'] as List)
              .map((data) => CustomerData.fromJson(data))
              .toList();
          customers = customerList;
          ToastUtil.showToast(msg: 'Customers loaded successfully', backgroundColor: Colors.green);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to fetch customers');
      }
    } catch (error) {
      print('Error fetching customers: $error');
      ToastUtil.showToast(msg: 'Error loading customers', backgroundColor: Colors.red);
    } finally {
      if(_isLoading){
        _isLoading = false;
        notifyListeners();
      }

    }
  }




  Future<void> addCustomer(BuildContext context) async {
    final String apiUrl = ApiEndPointsConstants.CreateCustomers;
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

      // Convert the list of selected items to a comma-separated string
      String occupations = selectedItems.map((item) => item.value).join(',');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': mailController.text,
          'occupation': occupations, // Send as a comma-separated string
        }),
      );

      // Log the request and response details for debugging
      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        ToastUtil.showToast(msg: 'לקוח נוסף בהצלחה',
            backgroundColor: Colors.green
        );
        fetchCustomers();
        Navigator.pop(context);

        clearForm();
      } else {
        throw Exception('Failed to add customer');
      }
    } catch (error) {
      print('Error adding customer: $error');
      ToastUtil.showToast(msg: 'שגיאה בהוספת לקוח',
          backgroundColor: Colors.red
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    final String apiUrl = ApiEndPointsConstants.DeleteCustomers;
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ToastUtil.showToast(
          msg: 'משתמש נמחק בהצלחה',
          backgroundColor: Colors.green,
        );
      } else {
        throw Exception('Failed to delete customer');
      }
    } catch (error) {
      print('Error deleting customer: $error');
      ToastUtil.showToast(
        msg: 'שגיאה במחיקת משתמש',
        backgroundColor: Colors.red,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> editCustomer(int customerId) async {
    if (!validateForm()) return;
    final String apiUrl = ApiEndPointsConstants.EditCustomers;

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }
      final occupation = selectedItems.map((item) => item.value).join(',');

      final response = await http.put(
        Uri.parse('$apiUrl/$customerId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': mailController.text,
          'occupation': occupation
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

  Future<void> setActiveStatus(int customerId, int activeStatus) async {
    final String apiUrl = ApiEndPointsConstants.EditCustomersStatus;
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('$apiUrl'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': customerId,
          'active': activeStatus,
        }),
      );

      print('Request: ${response.request}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Update local data if needed
        final customerIndex = customers.indexWhere((c) => c.id == customerId);
        if (customerIndex != -1) {
          customers[customerIndex].active = activeStatus;
        }
        notifyListeners();
        ToastUtil.showToast(msg: 'Status updated successfully', backgroundColor: Colors.green);
      } else {
        throw Exception('Failed to update status');
      }
    } catch (error) {
      print('Error updating status: $error');
      ToastUtil.showToast(msg: 'Error updating status', backgroundColor: Colors.red);
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
