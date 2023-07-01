import 'package:dio/dio.dart';
import 'package:ultroneous_practical/model/res_invalid_model.dart';

class ErrorHandler {
  static handleError(DioException e) {
    if (e.type == DioExceptionType.sendTimeout) {
      return ResInvalidBaseModel(message: "Timeout");
    }
    if (e.type == DioExceptionType.badResponse) {
      return ResInvalidBaseModel(message: "Something went wrong");
    }
    if (e.response?.statusCode == 404) {
      return ResInvalidBaseModel(message: "Unexpected Error Occurred");
    }
    return ResInvalidBaseModel.fromJson(e.response?.data ?? {});
  }
}
