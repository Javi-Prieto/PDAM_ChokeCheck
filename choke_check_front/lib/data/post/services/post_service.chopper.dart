// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PostService extends PostService {
  _$PostService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PostService;

  @override
  Future<Response<dynamic>> getAllPost(int number) {
    final Uri $url = Uri.parse('post?page=${number}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPost(Map<String, dynamic> post) {
    final Uri $url = Uri.parse('post');
    final $body = post;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createRate(
    String id,
    Map<String, dynamic> rate,
  ) {
    final Uri $url = Uri.parse('post/${id}/rate');
    final $body = rate;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deletePost(String id) {
    final Uri $url = Uri.parse('post/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addlike(String id) {
    final Uri $url = Uri.parse('post/like/${id}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteLike(String id) {
    final Uri $url = Uri.parse('post/like/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPostWithPhoto(
    MultipartFile file,
    String title,
    String type,
    String content,
  ) {
    final Uri $url = Uri.parse('post/');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'title',
        title,
      ),
      PartValue<String>(
        'type',
        type,
      ),
      PartValue<String>(
        'content',
        content,
      ),
      PartValueFile<MultipartFile>(
        'file',
        file,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
      responseConverter: JsonConverter.responseFactory,
    );
  }
}
