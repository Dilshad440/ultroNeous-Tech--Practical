import 'package:ultroneous_practical/configuration/base_mapper.dart';
import 'package:ultroneous_practical/model/mapper_response/user_model.dart';
import 'package:ultroneous_practical/model/response/user_response.dart';

class UserMapper extends BaseMapper<UserResponse, UserModel> {
  @override
  UserModel map(UserResponse t) {
    return UserModel(user: t.results);
  }
}
