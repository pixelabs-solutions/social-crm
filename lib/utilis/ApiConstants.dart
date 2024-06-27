// utils/api_constants.dart

class ApiEndPointsConstants {
  // Base URL
  static String baseUrl = "http://localhost:8000/api";

  // Authentications Endpoints
  static String loginApiUrl = '$baseUrl/auth/login';
  static String RegisterApiUrl = '$baseUrl/auth/register';

  //Customer Endpoints

  static String  listCustomers = '$baseUrl/customer/list';
  static String  CreateCustomers = '$baseUrl/customer/create';
  static String  EditCustomers = '$baseUrl/customer/edit';
  static String  DeleteCustomers = '$baseUrl/customer/delete';



}
