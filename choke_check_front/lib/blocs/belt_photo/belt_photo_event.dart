part of 'belt_photo_bloc.dart';

@immutable
sealed class BeltPhotoEvent {}

final class ValidateBeltEvent extends BeltPhotoEvent {
  final File file;

  ValidateBeltEvent({required this.file});
}
