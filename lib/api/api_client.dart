import 'dart:convert';
import 'dart:developer';
import 'package:itcity_online_store/api/exception.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static final String basePath = 'https://itcityonlinestore.com/api';
  static final String imageBasePath = basePath + '/files?filename=';

 // FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  Future<Response> invokeAPI(String path, String method, Object? body,
      {MultiPartRequestParam? multiPartRequestParams}) async {
    Map<String, String> headerParams = {
      
    };
    Response response;

    String url = basePath + path;
    print(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('email');
    print(isLoggedIn.toString());
    if(isLoggedIn) {

      String? token = prefs.getString('token');
      headerParams = {'Authorization': 'Bearer $token'};
      print(token);
    }
    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;
    if (multiPartRequestParams == null) {
      switch (method) {
        case "POST":
          response = await post(Uri.parse(url), headers: {'content-Type': 'application/json',}, body: body);
          break;
        case "PUT":
          response = await put(Uri.parse(url), headers: nullableHeaderParams, body: body);
          break;
        case "DELETE":
          response = await delete(Uri.parse(url), headers: nullableHeaderParams);
          break;
        case "POST_":
        response = await post(Uri.parse(url), headers: headerParams);
        break;
        default:
          response = await get(Uri.parse(url), headers: headerParams);
      }
    } else {
      var request = MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(multiPartRequestParams.fields!);
      request.files.addAll(multiPartRequestParams.files!);
      request.headers.addAll(nullableHeaderParams!);
      StreamedResponse streamedResponse = await request.send();
      String responseBody = await streamedResponse.stream.bytesToString();
      response = Response(
        responseBody,
        streamedResponse.statusCode,
        reasonPhrase: streamedResponse.reasonPhrase,
      );
    }
    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);
      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    return response;
  }

  String? _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}

class MultiPartRequestParam {
  final Map<String, String>? fields;
  final List<MultipartFile>? files;

  MultiPartRequestParam({this.fields, this.files});
}
