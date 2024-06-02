part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequest user;
  final String selectedBelt;

  DoRegisterEvent({required this.user, required this.selectedBelt});
}
