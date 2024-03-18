import 'package:choke_check_front/models/request/post_request.dart';
import 'package:choke_check_front/models/response/create_post_response.dart';
import 'package:choke_check_front/models/response/post_list_response/post_list_response.dart';

abstract class PostRepository {
  Future<PostListResponse> getAllPost();

  Future<CreatePostResponse> createPost(PostRequest post);

  Future<dynamic> deletePost(String id);

  Future<CreatePostResponse> addRate(String id, double rate);

  Future<dynamic> addLike(String id);

  Future<dynamic> deleteLike(String id);
}
