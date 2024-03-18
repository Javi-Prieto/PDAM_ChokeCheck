part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequest user;

  DoRegisterEvent({required this.user});
}
