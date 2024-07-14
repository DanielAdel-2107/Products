import 'package:dio/dio.dart';
import '../models/error_model.dart';
import 'server_exception.dart';

void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServerException(
          errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
        case 422:
        case 504:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        default:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
