abstract class ApiConsumer {
  Future<dynamic> get(
    String url, {
    Map<String, String>? queryParameters,
    Object? data,
  });
  Future<dynamic> post(
    String url, {
    Map<String, String>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
  Future<dynamic> patch(
    String url, {
    Map<String, String>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String url, {
    Map<String, String>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
}
