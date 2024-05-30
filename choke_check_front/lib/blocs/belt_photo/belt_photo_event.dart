part of 'belt_photo_bloc.dart';

@immutable
sealed class BeltPhotoEvent {}

final class ValidateBeltEvent extends BeltPhotoEvent {
  final File file;
  final String selectedBelt;

  ValidateBeltEvent({required this.file, required this.selectedBelt});
}
