import 'dart:io';

import 'package:choke_check_front/data/post/repository/post_repository.dart';
import 'package:choke_check_front/data/post/services/post_service.dart';
import 'package:choke_check_front/models/request/post_request.dart';
import 'package:choke_check_front/models/response/create_post_response.dart';
import 'package:choke_check_front/models/response/post_list_response/post_list_response.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' show MultipartFile;

class PostRepositoryImpl implements PostRepository {
  final PostService postService;

  PostRepositoryImpl({required this.postService});

  @override
  Future<PostListResponse> getAllPost(int number) async {
    final response = await postService.getAllPost(number);
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return PostListResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<CreatePostResponse> createPost(PostRequest post) async {
    final response = await postService.createPost(post.toMap());
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return CreatePostResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future deletePost(String id) async {
    final response = await postService.deletePost(id);
    if (response.isSuccessful) {
      return 'all correct';
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<CreatePostResponse> addRate(String id, double rate) async {
    final response = await postService.createRate(id, {'rate': rate});
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return CreatePostResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future addLike(String id) async {
    final response = await postService.addlike(id);
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return 'Success';
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future deleteLike(String id) async {
    final response = await postService.deleteLike(id);
    if (response.isSuccessful) {
      return 'all correct';
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<CreatePostResponse> createPostWithImage(File file, PostRequest post) async {
    MultipartFile fileSelected = await MultipartFile.fromPath('file', file.path);
    List<PartValue> requestParams = [];
    final response = await postService.createPostWithPhoto(fileSelected, post.title, post.type, post.content);
    if(response.isSuccessful){
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return CreatePostResponse.fromJson(response.bodyString);
      }
    }else{
      throw Exception(response.error);
    }
  }
}
