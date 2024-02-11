import 'package:dio/dio.dart';

class DioClient {
  Dio dio = Dio();

  Future<Response> post(String url, {required Map<String, dynamic> queryParameters, required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.post(url, queryParameters: queryParameters, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}