import 'package:choke_check_front/data/auth/repository/auth_repository.dart';
import 'package:choke_check_front/data/auth/services/auth_service.dart';
import 'package:choke_check_front/models/request/login_request.dart';
import 'package:choke_check_front/models/request/register_request.dart';
import 'package:choke_check_front/models/response/login_response.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;
  AuthRepositoryImpl({required this.authService});

  @override
  Future<LoginResponse> login(LoginRequest user) async {
    final loginResponse = await authService.login(user.toMap());
    if (loginResponse.isSuccessful) {
      return LoginResponse.fromJson(loginResponse.bodyString);
    } else {
      throw Exception(loginResponse.error.toString());
    }
  }

  @override
  Future<LoginResponse> register(RegisterRequest user) async {
    final registerResponse = await authService.register(user.toMap());
    if (registerResponse.isSuccessful) {
      return LoginResponse.fromJson(registerResponse.bodyString);
    } else {
      throw Exception(registerResponse.error.toString());
    }
  }
}
