import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioClient {
  final Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/v2/',
          receiveTimeout: Duration(minutes: 1),
          connectTimeout: Duration(minutes: 1)
      )
  )..interceptors.add(LogInterceptor(
    logPrint: (o) => debugPrint(o.toString()),
  ));

  Future get(String uri, ) async {
    try{
      final response = await dio.get(
        uri,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future post(
      String uri, {
        dynamic data,
        // Map<String, dynamic>? params,
        // Options? options,
      }) async {
    try{
      final response = await dio.post(
        uri,
        data: data,
        // queryParameters: params,
        // options: options,
      );
      return response.data;
    } catch(err) {
      return {'success': false};
    }
  }
}