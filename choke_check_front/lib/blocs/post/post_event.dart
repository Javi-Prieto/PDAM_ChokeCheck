part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

final class PostFetchEvent extends PostEvent {
  final int pageNumber;

  PostFetchEvent({required this.pageNumber});

}

final class PostGoFormEvent extends PostEvent {}

final class CreatePostEvent extends PostEvent {
  final PostRequest newPost;

  CreatePostEvent({required this.newPost});
}

final class DeletePostEvent extends PostEvent {
  final String id;

  DeletePostEvent({required this.id});
}

final class CreateRatePostEvent extends PostEvent {
  final double rate;
  final String id;
  CreateRatePostEvent(this.id, {required this.rate});
}

final class AddLikeEvent extends PostEvent {
  final String id;
  AddLikeEvent({required this.id});
}

final class DeleteLikeEvent extends PostEvent {
  final String id;

  DeleteLikeEvent({required this.id});
}
