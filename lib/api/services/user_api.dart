import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart';


class UserApi {
 // FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  ApiClient _apiclient = ApiClient();

  String _userRegistrationPath = '/createCustomer';
  String _updateCustomerDetailsPath = '/updateCustomerDetails';
  String _sellAccountCreationPath = '';
  String _removeUserAccountPath = '';
  String _signUpForNewsLetterPath = '';
  String _otpVerificationPath = '';
  String _forgotPasswordPath = '';
  String _customerLoginPath = '/login';
  String _checkMobileNumberStatusPath = '/checkMobileNumberStatus';
  String _checkEmailSubScriptionPath = '';
  String _checkEmailStatusPath = '/checkEmailStatus';
  String _customerInfoPath = '/customerinformation';

  Future<CustomerRegistration> registerUser(CustomerRegistration user) async {
    String customerJson =
        '{"customer_mobile": "${user.customerMobile}","password":"${user.password}","customer_email":"${user.customerEmail}"}';
    Response response =
        await _apiclient.invokeAPI(_userRegistrationPath, 'POST', customerJson);

    return CustomerRegistration.fromJson(jsonDecode(response.body)['data']);
  }

  Future updateUser(CustomerRegistration user) async {
    String customerJson =
        '{"customer_name":"${user.customerName}","customer_mobile": "${user.customerMobile}","customer_address":"${user.customerAddress}","customer_state":"${user.customerState}","customer_dist":"${user.customerDistrict}","customer_pincode":"${user.customerPincode}","customer_id":${user.customerId}}';
        print(customerJson);
    Response response =
        await _apiclient.invokeAPI(_updateCustomerDetailsPath, 'POST', customerJson);
        print("User Updated >>>>>>>>>>>>>" + response.body);
    return (jsonDecode(response.body)['success']);
  }

  Future<SellOnItcity> accountCreationToSellOnItCity(
      SellOnItcity sellAccount) async {
    Response response = await _apiclient.invokeAPI(
        _sellAccountCreationPath, 'POST', sellAccount.toJson());
    return SellOnItcity.fromJson(jsonDecode(response.body)['data']);
  }

  Future<String?> removeUserAccount(var customerId) async {
    Response response = await _apiclient.invokeAPI(
        _removeUserAccountPath, 'DELETE', customerId.toJson());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<String?> signUpForNewsLetter(var email) async {
    Response response = await _apiclient.invokeAPI(
        _signUpForNewsLetterPath, 'POST', email.toJson());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<String?> otpVerification(var otp) async {
    Response response =
        await _apiclient.invokeAPI(_otpVerificationPath, 'GET', otp.toJson());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<String?> forgotPassword(var email) async {
    Response response =
        await _apiclient.invokeAPI(_forgotPasswordPath, 'GET', email.toJson());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<String?> customerLogin(CustomerRegistration register) async {
    String customer =
        '{"customer_email": "${register.customerEmail}","password": "${register.password}"}';
    Response response =
        await _apiclient.invokeAPI(_customerLoginPath, 'POST', customer);


    String? token = (jsonDecode(response.body)['token']);

    return token;
  }

  Future<String?> checkMobileNumberStatus(var mobile) async {
    print(mobile);
    Response response = await _apiclient.invokeAPI(
        '$_checkMobileNumberStatusPath?customer_mobile=$mobile', 'GET', null);
           print("NumberStatus Response" + response.body.toString());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<String?> checkEmailSubScription(var email) async {
    Response response = await _apiclient.invokeAPI(
        _checkEmailSubScriptionPath, 'GET', email.toJson());
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<bool> checkEmailStatus(String mail) async {
    Response response = await _apiclient.invokeAPI(
        '$_checkEmailStatusPath?customer_email=$mail', 'GET', null);
        print("EmailStatus Response" + response.body.toString());
      var status = jsonDecode(response.body)['data'];
      if(status is bool) {
        return false;
      } else {
        return true;
      }
  }

  Future<CustomerRegistration> fetchCustomerInformation(String? mail) async {
    Response response = await _apiclient.invokeAPI(
        '$_customerInfoPath?customer_email=$mail', 'GET', null);
    return CustomerRegistration.fromJson(jsonDecode(response.body)['data'][0]);
  }
}
