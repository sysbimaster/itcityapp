import 'package:itcity_online_store/api/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthApi {
static final String basePath = 'https://api-test.itcityonlinestore.com/api/';
Future<ApiResponse> authenticateUser(CustomerRegistration register) async {
  ApiResponse _apiResponse = new ApiResponse();
  String customer =
        '{"customer_email": "${register.customerEmail}","password": "${register.password}"}';
  try {
    final response = await http.post(Uri.parse('https://api-test.itcityonlinestore.com/api/login'), body: customer);

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = (jsonDecode(response.body)['token']);
        break;
      case 401:
        _apiResponse.ApiError = (jsonDecode(response.body)['error']);
        break;
      default:
        _apiResponse.ApiError = (jsonDecode(response.body)['error']);
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}
 
}
