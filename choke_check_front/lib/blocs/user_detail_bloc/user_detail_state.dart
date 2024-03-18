part of 'user_detail_bloc.dart';

@immutable
sealed class UserDetailState {}

final class UserDetailInitial extends UserDetailState {}

final class UserDetailFetched extends UserDetailState {
  final UserDetailResponse user;

  UserDetailFetched({required this.user});
}

final class UserDetailFetchError extends UserDetailState {
  final String messageError;

  UserDetailFetchError({required this.messageError});
}
