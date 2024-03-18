part of 'user_detail_bloc.dart';

@immutable
sealed class UserDetailEvent {}

final class FetchUserDetailEvent extends UserDetailEvent {
  final String username;

  FetchUserDetailEvent({required this.username});
}
