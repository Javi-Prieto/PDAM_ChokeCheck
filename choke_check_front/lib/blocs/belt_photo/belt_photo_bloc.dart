import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/photo/repository/photo_belt_repository.dart';
import '../../models/response/validate_belt_response/validate_belt_response.dart';

part 'belt_photo_event.dart';
part 'belt_photo_state.dart';

class BeltPhotoBloc extends Bloc<BeltPhotoEvent, BeltPhotoState> {
  final PhotoBeltRepository photoBeltRepository;
  BeltPhotoBloc(this.photoBeltRepository) : super(BeltPhotoInitial()) {
    on<BeltPhotoEvent>((event, emit) {
        on<ValidateBeltEvent>(_validateBelt);
    });
  }

  void _validateBelt(ValidateBeltEvent event, Emitter<BeltPhotoState> emit) async{
    emit(ValidateBeltLoading());
    try{
      final ValidateBeltResponse response = await photoBeltRepository.validateBelt(event.file);
      if(response.beltColor!.toLowerCase() == event.selectedBelt.toLowerCase()){
        emit(ValidateBeltSuccess());
      }else{
        emit(ValidateBeltNotTheSameError(errorMessage: 'The belt picked and the photo is not the same'));
      }
    }on Exception catch (e){
      emit(ValidateBeltError(errorMessage: e.toString()));
    }

  }
}
