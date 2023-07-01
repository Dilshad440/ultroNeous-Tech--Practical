import 'package:ultroneous_practical/mapper/user_mapper.dart';
import 'package:ultroneous_practical/model/mapper_response/user_model.dart';
import 'package:ultroneous_practical/source/api_source.dart';

class UserRepository {
  final _apiSource = ApiSource();
  final _userMapper = UserMapper();

  Future<UserModel> fetchUsers({required int page}) async {
    return _apiSource.fetchUser(page: page).then((value) => Future.value(_userMapper.map(value)));
  }
}
