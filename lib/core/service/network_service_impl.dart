import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fin_smart/application.dart';
import 'package:fin_smart/core/common/cubits/app_user/user_session_cubit.dart';
import 'package:fin_smart/core/constants/api_endpoints.dart';
import 'package:fin_smart/core/utils/enums.dart';
import 'package:fin_smart/inti.dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_service.dart';

class NetworkServicesImpl implements NetworkServices {
  late final Dio _dio;
  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

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
        onRequest: (options, handler) async {
          final headers = await mainHeaders();
          options.headers.addAll(headers);
          handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 &&
              !e.requestOptions.extra.containsKey('retry')) {
            final completer = Completer<Response>();

            _retryQueue.add(() async {
              final opts = e.requestOptions;
              opts.extra['retry'] = true;
              try {
                final response = await _dio.fetch(opts);
                completer.complete(response);
              } catch (err) {
                completer.completeError(err);
              }
            });

            if (!_isRefreshing) {
              _isRefreshing = true;
              final success = await _refreshToken();
              _isRefreshing = false;

              if (success) {
                for (final retry in _retryQueue) {
                  await retry();
                }
                _retryQueue.clear();
              } else {
                _retryQueue.clear();
                return handler.reject(e);
              }
            }

            return handler.resolve(await completer.future);
          }
          handler.next(e);
        },
        onResponse: (response, handler) {
          handler.next(response);
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
      final response = await _dio.get(url, options: Options(headers: headers));
      return returnResponse(_toResponse(response));
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
        options: Options(headers: headers),
      );
      return returnResponse(_toResponse(response));
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

  Future<bool> _refreshToken() async {
    final cubit = serviceLocator<UserSessionCubit>();
    final refreshToken = await cubit.localData.getRefreshToken();

    if (refreshToken.isEmpty) {
      return false;
    }

    try {
      final response = await _dio.post(
        ApiEndPoints.refreshToken,
        data: json.encode({'refresh_token': refreshToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.data);
        final newAccessToken = decoded['access_token'];
        final newRefreshToken = decoded['refresh_token'];

        await cubit.localData.setRefreshToken(newRefreshToken);

        navigatorKey.currentContext?.read<UserSessionCubit>().setAppUserStatus(
          UserSessionStatus.authenticated,
          accessToken: newAccessToken,
        );

        return true;
      }
    } catch (_) {}
    return false;
  }

  static Future<Map<String, String>> mainHeaders({String? token}) async {
    final localToken =
        serviceLocator<UserSessionCubit>().state.accessToken ?? '';
    if (localToken.isNotEmpty || token != null) {
      return {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${token ?? localToken}',
      };
    }
    return {'Content-Type': 'application/json', 'Accept': '*/*'};
  }

  Response _toResponse(Response dioResponse) {
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
