part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserEvent {}

final class DoEditEvent extends EditUserEvent {
  final EditUserRequest user;

  DoEditEvent({required this.user});
}
