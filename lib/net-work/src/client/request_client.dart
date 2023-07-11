import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_seo_servers/config/config.dart';
import 'package:go_seo_servers/model/model.dart';
import 'package:go_seo_servers/model/src/response/api_response_entity.dart';
import 'package:go_seo_servers/net-work/src/client/exception.dart';

RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;

  RequestClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: RequestConfig.url,
        connectTimeout: const Duration(
          milliseconds: RequestConfig.connectTimeout,
        ),
      ),
    );
  }
  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  Future<T?> request<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;
      data = _convertRequestData(data);
      Response response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      print(response);
      return _handleResponse<T>(response);
    } catch (e) {
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        throw exception;
      }
    }
    return null;
  }

  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        queryParameters: queryParameters, headers: headers, onError: onError);
  }

  Future<T?> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      method: "POST",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<T?> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "DELETE",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  Future<T?> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "PUT",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    if (response.data["code"] == 0) {
      if (T.toString() == (RawData).toString()) {
        RawData raw = RawData();
        raw.value = response.data;
        return raw as T;
      } else {
        ApiResponseEntity<T> apiResponse =
            ApiResponseEntity<T>.fromJson(response.data);
        return _handleBusinessResponse<T>(apiResponse);
      }
    } else {
      var exception = ApiException(
        response.data["code"],
        response.data["msg"],
      );
      throw exception;
    }
  }

  ///业务内容处理
  T? _handleBusinessResponse<T>(ApiResponseEntity<T> response) {
    if (response.code == RequestConfig.requestSuccessful) {
      return response.data;
    } else {
      var exception = ApiException(response.code, response.msg);
      throw exception;
    }
  }
}
