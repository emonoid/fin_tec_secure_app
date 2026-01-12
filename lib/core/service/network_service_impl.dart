import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:fin_smart/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fin_smart/inti.dependencies.dart';
import 'package:http/http.dart'; 
import 'network_service.dart';
import 'package:http/http.dart' as http;

class NetworkServicesImpl implements NetworkServices {
  @override
  Future<dynamic> getApi(url,{Map<String, String>? headers, String? token, int? timeOut,}) async {
    ///check this request url and print log message
    log('====> Http Call: $url');

    Map<String, String> finalHeaders = headers ?? await mainHeaders(token: token);

    dynamic responseJson;
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: finalHeaders, 
      );
      responseJson = await returnResponse(response);
      ///print output result log message
      log('====> Http Response: [${response.statusCode}] $url\n${utf8.decode(response.bodyBytes)}');

    } on SocketException {
      responseJson = await returnResponse(Response(
          "{\"success\": false, \"message\": \"Server not found!\"}", 500));
    } catch (e) {
      responseJson = await returnResponse(Response(
          "{\"success\": false, \"message\": \"Something went wrong!\"}", 500));
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(data, url,{Map<String, String>? headers, String? token,bool bodyEncode = true, int? timeOut,}) async {
    Map<String, String> finalHeaders = headers ?? await mainHeaders(token: token);
    ///check this request url and print log message
    log('====> Http Call: $url');
    log('====> Http Request Body : ${json.encode(data)}');

    Map<String, dynamic> responseJson;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: finalHeaders,
        body: json.encode(data),
      );
      responseJson = await returnResponse(response);

      ///print output result log message
      log('====> Http Response: [${response.statusCode}] $url\n${utf8.decode(response.bodyBytes)}');

    } on SocketException {
      responseJson = await returnResponse(Response(
          "{\"success\": false, \"message\": \"Server not found!\"}", 500));
    } catch (e) {
      responseJson = await returnResponse(Response(
          "{\"success\": false, \"message\": \"Something went wrong!\"}", 500));
    }

    return responseJson;
  }

  static Future<Map<String, String>> mainHeaders({String? token}) async{
    String localToken = await serviceLocator<AppUserCubit>().loadToken();
    Map<String, String> headers;
    if (localToken.isNotEmpty || token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Vary': 'Accept',
        "Accept": "*",
        "Authorization": 'Bearer ${token ?? localToken}',
      };
    } else {
      headers = {
        'Content-Type': 'application/json',
        'Vary': 'Accept',
        "Accept": "*",
      };
    }
    return headers;
  }

}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = json.decode(response.body);
      return responseJson;
    case 400:
      dynamic responseJson = json.decode(response.body);
      return responseJson;
    case 401:
      dynamic responseJson = json.decode(response.body);
      return responseJson;
    case 500:
      dynamic responseJson = json.decode(response.body);
      return responseJson;
    case 422:
      dynamic responseJson = json.decode(response.body);
      return responseJson;
    default:
      throw Exception(
          'Error ccoured while communicating with server ${response.statusCode}');
  }
}
