import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../env/env.dart';

import 'api_error.dart';

class DioService {
  DioService(this.ref) {
    dio = Dio()
      ..options.baseUrl = 'https://tasty.p.rapidapi.com/'
      ..options.headers['X-RapidAPI-Key'] = Env.tastyApiKey
      ..options.headers['X-RapidAPI-Host'] = 'tasty.p.rapidapi.com'
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
  }

  final ProviderRef ref;
  late final Dio dio;

  Future<T> request<T>({
    required String url,
    required T Function(dynamic data) builder,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final options = Options(
        method: 'GET',
        headers: {
          'X-RapidAPI-Key': Env.tastyApiKey,
          'X-RapidAPI-Host': 'tasty.p.rapidapi.com',
        },
      );

      final Response response;
      response = await dio.get(
        url,
        options: options,
        queryParameters: parameters,
      );

      return builder(response.data);
    } on DioError catch (e) {
      try {
        final errorData = e.response?.data as Map<String, dynamic>;

        if (e.message!.contains('Network is unreachable')) {
          throw ApiError(message: 'No internet connection');
        }

        /// Process status code
        switch (e.response?.statusCode) {
          case 401:
            throw ApiError(message: 'Invalid API Key');
          case 404:
            throw ApiError(message: 'Not found');
          default:
            throw ApiError.fromJson(errorData);
        }
      } on TypeError catch (_) {
        throw ApiError(message: 'Unsuccessfully tried parsing error message.');
      }
    }
  }
}
