import 'package:choke_check_front/data/interceptors/my_header_interceptor.dart';
import 'package:chopper/chopper.dart';
part 'user_service.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  static UserService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://18.171.149.35:8080/'),
      services: [_$UserService()],
      interceptors: [MyHeaderInterceptor()],
      converter: JsonConverter(),
    );
    return _$UserService(client);
  }

  @Get(path: 'user/{username}')
  Future<Response> getUserByUsername(@Path() String username);

  @Put(path: 'edit/my_profile')
  Future<Response> editMyProfile(@Body() Map<String, dynamic> user);
}
