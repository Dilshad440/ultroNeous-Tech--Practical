import 'package:dio/dio.dart';
import 'package:ultroneous_practical/configuration/api_config/rest_client.dart';
import 'package:ultroneous_practical/configuration/error_handel.dart';
import 'package:ultroneous_practical/model/response/user_response.dart';
import 'package:ultroneous_practical/utils/constant/api_constant.dart';

class ApiSource {
  final _restClient = RestClient();

  Future<UserResponse> fetchUser({required int page}) async {
    try {
      final response = await _restClient.dio.get(ApiConstant.baseUrl, queryParameters: {
        "results": 15,
        "page": page,
      });
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }
}
