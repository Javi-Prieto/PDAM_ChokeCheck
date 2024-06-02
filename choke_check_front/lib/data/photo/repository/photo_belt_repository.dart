import 'dart:io';

import '../../../models/response/validate_belt_response/validate_belt_response.dart';

abstract class PhotoBeltRepository{
  Future<ValidateBeltResponse> validateBelt(File image);
}