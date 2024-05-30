
import 'dart:io';

import 'package:chopper/chopper.dart';
part 'photo_belt_service.chopper.dart';

@ChopperApi()
abstract class PhotoBeltService extends ChopperService {
  static PhotoBeltService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://10.0.2.2:9000/'),
      services: [_$PhotoBeltService()],
      converter: JsonConverter(),
    );
    return _$PhotoBeltService(client);
  }

  @Post(path: 'validate_belt_color')
  Future<Response> validateBelt(@Body() File file);
}