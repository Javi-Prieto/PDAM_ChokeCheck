import 'dart:async';

import 'package:choke_check_front/data/interceptors/my_header_interceptor.dart';
import 'package:choke_check_front/models/request/post_request.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' show MultipartFile;
part 'post_service.chopper.dart';

@ChopperApi()
abstract class PostService extends ChopperService {
  static PostService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://10.0.2.2:8080/'),
      services: [_$PostService()],
      interceptors: [MyHeaderInterceptor()],
      converter: JsonConverter(),
    );
    return _$PostService(client);
  }

  @Get(path: 'post?page={number}')
  Future<Response> getAllPost(@Path() int number);

  @Post(path: 'post')
  Future<Response> createPost(@Body() Map<String, dynamic> post);

  @Post(path: 'post/{id}/rate')
  Future<Response> createRate(
      @Path() String id, @Body() Map<String, dynamic> rate);

  @Delete(path: 'post/{id}')
  Future<Response> deletePost(@Path() String id);

  @Post(path: 'post/like/{id}')
  Future<Response> addlike(@Path() String id);

  @Delete(path: 'post/like/{id}')
  Future<Response> deleteLike(@Path() String id);

  @Post(path: 'post/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
    response: JsonConverter.responseFactory
  )
  @multipart
  Future<Response> createPostWithPhoto(@PartFile('file') MultipartFile file, @Part('title') String title, @Part('type') String type, @Part('content') String content);

}

