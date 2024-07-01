// utils/api_constants.dart

class ApiEndPointsConstants {
  // Base URL
  static String baseUrl = "https://scrm-apis.woo-management.com/api";

  // Authentications Endpoints
  static String loginApiUrl = '$baseUrl/auth/login';
  static String RegisterApiUrl = '$baseUrl/auth/register';
  static String  GetUserProfile = '$baseUrl/auth/profile';
  static String  Conatcts = '$baseUrl/contacts/list';

  //Customer Endpoints

  static String  listCustomers = '$baseUrl/customer/list';
  static String  CreateCustomers = '$baseUrl/customer/create';
  static String  EditCustomers = '$baseUrl/customer/edit';
  static String  DeleteCustomers = '$baseUrl/customer/delete';
  static String  CountCustomers = '$baseUrl/customer/count';
  static String  EditCustomersStatus = '$baseUrl/customer/update-active-status';

  //Status Apis

  static String UpcomingSatus = '$baseUrl/status/list';
  static String FetchStatus = '$baseUrl/status/list';
  static String FetchStatusViews = '$baseUrl/status/list/';




}
