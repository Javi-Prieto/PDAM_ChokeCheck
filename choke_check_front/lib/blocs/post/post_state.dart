part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostFetched extends PostState {
  final List<Content> postList;

  PostFetched({required this.postList});
}

final class PostFetchError extends PostState {
  final String messageError;

  PostFetchError({required this.messageError});
}

final class PostFormClick extends PostState {}

final class CreatePostInitial extends PostState {}

final class CreatePostLoading extends PostState {}

final class CreatePostSuccess extends PostState {}

final class CreatePostError extends PostState {
  final String messageError;

  CreatePostError({required this.messageError});
}

final class DeletePostSuccess extends PostState {}

final class DeletePostError extends PostState {
  final String messageError;

  DeletePostError({required this.messageError});
}

final class CreateRateSuccess extends PostState {}

final class CreateRateError extends PostState {
  final String messageError;

  CreateRateError({required this.messageError});
}

final class AddLikeSuccess extends PostState {}

final class AddLikeError extends PostState {
  final String messageError;

  AddLikeError({required this.messageError});
}

final class DeleteLikeSuccess extends PostState {}

final class DeleteLikeError extends PostState {
  final String messageError;

  DeleteLikeError({required this.messageError});
}
