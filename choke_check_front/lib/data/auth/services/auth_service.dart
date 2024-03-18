import 'package:chopper/chopper.dart';
part 'auth_service.chopper.dart';

@ChopperApi()
abstract class AuthService extends ChopperService {
  static AuthService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://10.0.2.2:8080/'),
      services: [_$AuthService()],
      converter: JsonConverter(),
    );
    return _$AuthService(client);
  }

  @Post(path: 'login')
  Future<Response> login(@Body() Map<String, dynamic> user);

  @Post(path: 'register')
  Future<Response> register(@Body() Map<String, dynamic> user);
}
