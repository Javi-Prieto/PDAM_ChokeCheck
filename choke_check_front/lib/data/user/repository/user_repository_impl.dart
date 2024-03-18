import 'package:choke_check_front/data/user/repository/user_repository.dart';
import 'package:choke_check_front/data/user/service/user_service.dart';
import 'package:choke_check_front/models/request/edit_request.dart';
import 'package:choke_check_front/models/response/user_detail_response/user_detail_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<UserDetailResponse> getUserByUsername(String username) async {
    final response = await userService.getUserByUsername(username);
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception("No token provided");
      } else {
        return UserDetailResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<UserDetailResponse> editUser(EditUserRequest user) async {
    final response = await userService.editMyProfile(user.toMap());
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception("No token provided");
      } else {
        return UserDetailResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }
}
