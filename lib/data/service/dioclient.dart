import 'package:dio/dio.dart';
import 'package:main_cartify/data/service/endpoints.dart';
import 'package:main_cartify/helper/helper.dart' show logger;

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = const Duration(
        seconds: Endpoints.connectionTimeout,
      )
      ..options.receiveTimeout = const Duration(
        seconds: Endpoints.receiveTimeout,
      )
      ..options.contentType = 'application/json'
      ..options.headers['Content-Type'] = 'application/json'
      ..options.responseType = ResponseType.json
      ..options.followRedirects = false
      ..options.validateStatus = (status) {
        return status! < 500;
      }
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.stackTrace);
      }
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }
}
