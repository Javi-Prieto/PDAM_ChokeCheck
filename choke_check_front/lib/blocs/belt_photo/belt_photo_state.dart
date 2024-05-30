part of 'belt_photo_bloc.dart';

@immutable
sealed class BeltPhotoState {}

final class BeltPhotoInitial extends BeltPhotoState {}

final class ValidateBeltLoading extends BeltPhotoState {}

final class ValidateBeltSuccess extends BeltPhotoState {}

final class ValidateBeltNotTheSameError extends BeltPhotoState {
  final String errorMessage;

  ValidateBeltNotTheSameError({required this.errorMessage});
}

final class ValidateBeltError extends BeltPhotoState {
  final String errorMessage;

  ValidateBeltError({required this.errorMessage});
}
