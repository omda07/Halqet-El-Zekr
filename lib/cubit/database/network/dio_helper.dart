import 'package:dio/dio.dart';

import 'end_points.dart';

class DioHelper{
  static late Dio dio;
  static init(String baseUrl){
    dio =Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }
      )
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}