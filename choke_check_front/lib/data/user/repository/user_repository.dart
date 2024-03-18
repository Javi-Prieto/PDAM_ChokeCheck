import 'package:choke_check_front/models/request/edit_request.dart';
import 'package:choke_check_front/models/response/user_detail_response/user_detail_response.dart';

abstract class UserRepository {
  Future<UserDetailResponse> getUserByUsername(String username);

  Future<UserDetailResponse> editUser(EditUserRequest user);
}
