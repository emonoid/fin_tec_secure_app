import 'dart:convert'; 
import 'package:dio/dio.dart';
import 'package:fin_smart/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fin_smart/inti.dependencies.dart';
import 'network_service.dart';

class NetworkServicesImpl implements NetworkServices {
  late final Dio _dio;

  NetworkServicesImpl() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        responseType: ResponseType.plain,
        validateStatus: (status) => status != null,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
  }

  @override
  Future<dynamic> getApi(
    url, {
    Map<String, String>? headers,
    String? token,
    int? timeOut,
  }) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers ?? await mainHeaders(token: token)),
      );
      return returnResponse(_toHttpResponse(response));
    } on DioException catch (_) {
      return returnResponse(
        Response(
          requestOptions: RequestOptions(path: url),
          data: '{"success": false, "message": "Server not found!"}',
          statusCode: 500,
        ),
      );
    } catch (_) {
      return returnResponse(
        Response(
          requestOptions: RequestOptions(path: url),
          data: '{"success": false, "message": "Something went wrong!"}',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<dynamic> postApi(
    data,
    url, {
    Map<String, String>? headers,
    String? token,
    bool bodyEncode = true,
    int? timeOut,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: bodyEncode ? json.encode(data) : data,
        options: Options(headers: headers ?? await mainHeaders(token: token)),
      );
      return returnResponse(_toHttpResponse(response));
    } on DioException catch (_) {
      return returnResponse(
        Response(
          requestOptions: RequestOptions(path: url),
          data: '{"success": false, "message": "Server not found!"}',
          statusCode: 500,
        ),
      );
    } catch (_) {
      return returnResponse(
        Response(
          requestOptions: RequestOptions(path: url),
          data: '{"success": false, "message": "Something went wrong!"}',
          statusCode: 500,
        ),
      );
    }
  }

  static Future<Map<String, String>> mainHeaders({String? token}) async {
    String localToken = serviceLocator<AppUserCubit>().state.accessToken ?? '';
    if (localToken.isNotEmpty || token != null) {
      return {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${token ?? localToken}',
      };
    }
    return {'Content-Type': 'application/json', 'Accept': '*/*'};
  }

  Response _toHttpResponse(Response dioResponse) {
    return Response(
      requestOptions: dioResponse.requestOptions,
      data: dioResponse.data,
      statusCode: dioResponse.statusCode,
    );
  }
}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return {
        "success": true,
        "message": "User Created",
        "data": response.data,
        "status_code": response.statusCode,
      };
    case 400:
    case 401:
    case 422:
    case 500:
      return {
        "success": false,
        "message": response.data,
        "status_code": response.statusCode,
      };
    default:
      throw Exception(
        'Error ccoured while communicating with server ${response.statusCode}',
      );
  }
}
