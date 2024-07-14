import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:task/services/api_interceptor.dart';
import 'package:task/services/end_points.dart';
import 'package:task/view_models/product_cubit/product_cubit.dart';
import 'services/api_consumer.dart';
import 'services/dio_consumer.dart';

final GetIt product = GetIt.instance;

void setupInjection() {
  // Register Dio
  product.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    return dio;
  });

  // Register ApiConsumer
  product.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: product()));

  // Register ProductCubit
  product.registerFactory(() => ProductCubit(product()));
}
