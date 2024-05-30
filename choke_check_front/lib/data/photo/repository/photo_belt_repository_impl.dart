import 'dart:convert';
import 'dart:io';

import 'package:choke_check_front/data/photo/repository/photo_belt_repository.dart';
import 'package:choke_check_front/data/photo/service/photo_belt_service.dart';
import 'package:choke_check_front/models/response/validate_belt_response/validate_belt_response.dart';

class PhotoBeltRepositoryImpl extends PhotoBeltRepository{
  final PhotoBeltService photoBeltService;

  PhotoBeltRepositoryImpl({required this.photoBeltService});
  
  @override
  Future<ValidateBeltResponse> validateBelt(File image) async {
    final validateResponse = await photoBeltService.validateBelt(image);
    if(validateResponse.isSuccessful){
      return ValidateBeltResponse.fromJson(validateResponse.bodyString);
    }else{
      throw Exception(validateResponse.error.toString());
    }
  }
  
}