
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' show MultipartFile;
part 'photo_belt_service.chopper.dart';

@ChopperApi()
abstract class PhotoBeltService extends ChopperService {
  static PhotoBeltService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://10.0.2.2:9000/'),
      services: [_$PhotoBeltService()],
      converter: FormUrlEncodedConverter(),
      interceptors: [
        const HeadersInterceptor({
          "Content-Type": "multipart/form-data",
          'Accept': '*/*',
        }),
      ]
    );
    return _$PhotoBeltService(client);
  }

  @Post(path: 'validate_belt_color')
  @multipart
  Future<Response> validateBelt(@PartFile('file') MultipartFile file);
}