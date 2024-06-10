import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/post/repository/post_repository.dart';
import 'package:choke_check_front/models/request/post_request.dart';
import 'package:choke_check_front/models/response/post_list_response/content.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' show MultipartFile;


part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<PostFetchEvent>(_onPostFetch);
    on<PostGoFormEvent>(_onGoForm);
    on<CreatePostEvent>(_onCreatePost);
    on<DeletePostEvent>(_onDeletePost);
    on<CreateRatePostEvent>(_onCreateRateEvent);
    on<AddLikeEvent>(_onAddLike);
    on<DeleteLikeEvent>(_onDeleteLike);
  }
  _onPostFetch(PostFetchEvent event, Emitter<PostState> emit) async {
    try {
      final postResponse = await repository.getAllPost(event.pageNumber);
      emit(PostFetched(postList: postResponse.content!));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(messageError: e.toString()));
    }
  }

  _onCreateRateEvent(CreateRatePostEvent event, Emitter<PostState> emit) async {
    try {
      await repository.addRate(event.id, event.rate);
      emit(CreateRateSuccess());
      return;
    } on Exception catch (e) {
      emit(CreateRateError(messageError: e.toString()));
    }
  }

  _onGoForm(PostGoFormEvent event, Emitter<PostState> emit) {
    emit(PostFormClick());
    return;
  }

  _onCreatePost(CreatePostEvent event, Emitter<PostState> emit) async {
    emit(CreatePostInitial());
    try {
      if(event.file.path.isEmpty){
        await repository.createPost(event.newPost);
        emit(CreatePostSuccess());
      }else{
        await repository.createPostWithImage(event.file, event.newPost);
        emit(CreatePostSuccess());
      }
      return;
    } on Exception catch (e) {
      emit(CreatePostError(messageError: e.toString()));
    }
  }

  _onDeletePost(DeletePostEvent event, Emitter<PostState> emit) async {
    try {
      await repository.deletePost(event.id);
      emit(DeletePostSuccess());
      return;
    } on Exception catch (e) {
      emit(DeletePostError(messageError: e.toString()));
    }
  }

  _onAddLike(AddLikeEvent event, Emitter<PostState> emit) async {
    try {
      await repository.addLike(event.id);
      emit(AddLikeSuccess());
      return;
    } on Exception catch (e) {
      emit(AddLikeError(messageError: e.toString()));
    }
  }

  _onDeleteLike(DeleteLikeEvent event, Emitter<PostState> emit) async {
    try {
      await repository.deleteLike(event.id);
      emit(DeleteLikeSuccess());
      return;
    } on Exception catch (e) {
      emit(DeleteLikeError(messageError: e.toString()));
    }
  }
}
