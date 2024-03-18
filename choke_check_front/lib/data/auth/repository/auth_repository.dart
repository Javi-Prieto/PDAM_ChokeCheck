import 'package:choke_check_front/models/request/login_request.dart';
import 'package:choke_check_front/models/request/register_request.dart';
import 'package:choke_check_front/models/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest user);

  Future<LoginResponse> register(RegisterRequest user);
}
