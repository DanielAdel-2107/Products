import 'package:dio/dio.dart';
import 'package:task/utils/error_handler.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});
  @override
  Future get(String url,
      {Map<String, String>? queryParameters, dynamic data}) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(String url,
      {Map<String, String>? queryParameters,
      dynamic data,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(
        url,
        queryParameters: queryParameters,
        data:
            isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future patch(String url,
      {Map<String, String>? queryParameters,
      dynamic data,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(
        url,
        queryParameters: queryParameters,
        data:
            isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future delete(String url,
      {Map<String, String>? queryParameters,
      dynamic data,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(
        url,
        queryParameters: queryParameters,
        data:
            isFormData ? FormData.fromMap(data): data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
