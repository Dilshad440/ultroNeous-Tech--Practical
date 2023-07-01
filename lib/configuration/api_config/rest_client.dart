import 'package:dio/dio.dart';
import 'package:ultroneous_practical/configuration/api_config/app_interceptors.dart';

class RestClient {
  late Dio dio;

  RestClient() {
    dio = Dio(BaseOptions(
      // baseUrl: ApiConstant.baseUrl,
      responseType: ResponseType.json,
    ));
    dio.interceptors.add(AppInterceptor());
  }
}
