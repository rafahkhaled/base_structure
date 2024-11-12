import 'dart:convert';
import 'dart:io';
import 'package:base_structure/core/network/i_network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkService implements INetworkService {
  final Dio _dio;
  final String baseUrl;

  NetworkService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _setupInterceptors();
  }

  @override
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(endpoint,
          queryParameters: {},
          options: Options(
            headers: headers,
          ));
      return _parseResponse(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return _parseResponse(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return _parseResponse(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await _dio.delete(endpoint, options: Options(headers: headers));
      return _parseResponse(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> uploadFileWithData(
      String endpoint, File file, Map<String, String> formData,
      {Map<String, String>? headers}) async {
    try {
      final formDataObj = FormData.fromMap({
        ...formData,
        'file': await MultipartFile.fromFile(file.path),
      });

      final response = await _dio.post(
        endpoint,
        data: formDataObj,
        options: Options(headers: headers),
      );

      return _parseResponse(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<File> downloadFile(String endpoint, String filePath,
      {Map<String, String>? headers}) async {
    try {
      await _dio.download(
        endpoint,
        filePath,
        options: Options(headers: headers),
      );

      return File(filePath);
    } on DioException {
      rethrow;
    }
  }

  Map<String, dynamic> _parseResponse(Response response) {
    if (response.data != null) {
      return response.data is Map<String, dynamic>
          ? response.data
          : json.decode(response.data.toString());
    }
    return {};
  }

  void _setupInterceptors() {
    // Request Interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('*** Request Start ***');
        debugPrint('URL: ${options.uri}');
        debugPrint('Method: ${options.method}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Query Parameters: ${options.queryParameters}');
        debugPrint('Body: ${options.data}');
        debugPrint('*** Request End ***');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Log response details
        debugPrint('*** Response Start ***');
        debugPrint('Status Code: ${response.statusCode}');
        debugPrint('Headers: ${response.headers}');
        debugPrint('Response Data: ${response.data}');
        debugPrint('*** Response End ***');

        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Status Code: ${e.response?.statusCode}');
        debugPrint('Headers: ${e.response?.headers}');
        debugPrint('Response Data: ${e.response?.data}');
        return handler.next(e);
      },
    ));

    // Example of adding a custom header to all requests
    _dio.options.headers['Authorization'] = 'Bearer your_access_token_here';
  }
}
