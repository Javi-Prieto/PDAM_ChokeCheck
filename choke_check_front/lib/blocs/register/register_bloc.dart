import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository.dart';
import 'package:choke_check_front/models/request/register_request.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }
  void _doRegister(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(DoRegisterLoading());
    final SharedPreferences prefs = await _prefs;
    try {
      final response = await authRepository.register(event.user);
      if(response.userBeltColor!.toLowerCase() == event.selectedBelt.toLowerCase()){
        prefs.clear();
        prefs.setString('bearer_token', response.token!);
        prefs.setString('username', response.username!);
        prefs.setString('user_belt', response.userBeltColor!);
        emit(DoRegisterSuccess());
      }else{
        emit(DoRegisterError('The belt selected and the belt of the photo does not correspond'));
      }
      return;
    } on Exception catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
