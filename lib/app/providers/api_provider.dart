/*
 * File name: api_provider.dart
 * Last modified: 2022.02.14 at 12:25:29
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';

import '../../common/custom_trace.dart';
import '../services/auth_service.dart';
import '../services/global_service.dart';
import 'dio_client.dart';

mixin ApiClient {
  final globalService = Get.find<GlobalService>();
  final authService = Get.find<AuthService>();
  String baseUrl = '';
  late DioClient _httpClient;
  late dio.Options _optionsNetwork;
  late dio.Options _optionsCache;

  DioClient get httpClient => _httpClient;

  dio.Options get optionsNetwork => _optionsNetwork;

  dio.Options get optionsCache => _optionsCache;

  Future<ApiClient> init() async {
    _httpClient = DioClient(this.baseUrl, new dio.Dio());
    _optionsNetwork = _httpClient.optionsNetwork;
    _optionsCache = _httpClient.optionsCache;
    return this;
  }

  bool isLoading({String? task, List<String>? tasks}) {
    return _httpClient.isLoading(task: task, tasks: tasks);
  }

  void setLocale(String locale) {
    _optionsNetwork.headers?['Accept-Language'] = locale;
    _optionsCache.headers?['Accept-Language'] = locale;
  }

  void forceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsCache = dio.Options(headers: _optionsCache.headers);
      _optionsNetwork = dio.Options(headers: _optionsNetwork.headers);
    }
  }

  void unForceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsNetwork = buildCacheOptions(Duration(days: 3),
          forceRefresh: true, options: _optionsNetwork);
      _optionsCache = buildCacheOptions(Duration(minutes: 10),
          forceRefresh: false, options: _optionsCache);
    }
  }

  String getBaseUrl(String path) {
    if (baseUrl.isEmpty) {
      Get.log('Error: baseUrl is empty when calling getBaseUrl with path: $path');
      return path;
    }
    // Remove leading slash from path if present
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    // Ensure baseUrl doesn't have trailing slash
    String cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    // Build final URL
    return '$cleanBaseUrl/$path';
  }

  String getApiBaseUrl(String path) {
    String _apiPath = globalService.global.value.apiPath ?? '';
    if (_apiPath.isEmpty) {
      Get.log('Warning: apiPath is empty in getApiBaseUrl');
    }
    // Remove leading slash from path if present
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    // Remove leading slash from apiPath if present
    if (_apiPath.startsWith('/')) {
      _apiPath = _apiPath.substring(1);
    }
    // Build the full API path
    String fullPath = _apiPath.isEmpty ? path : '$_apiPath/$path';
    return getBaseUrl(fullPath);
  }

  Uri getApiBaseUri(String path) {
    return Uri.parse(getApiBaseUrl(path));
  }

  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }
}
