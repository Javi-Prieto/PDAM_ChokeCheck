import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository.dart';
import 'package:choke_check_front/models/request/login_request.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(DoLoginLoading());
    final SharedPreferences prefs = await _prefs;
    try {
      final LoginRequest loginRequest =
          LoginRequest(username: event.username, password: event.password);
      final response = await authRepository.login(loginRequest);
      prefs.clear();
      prefs.setString('bearer_token', response.token!);
      prefs.setString('username', response.username!);
      prefs.setString('user_belt', response.userBeltColor!);
      emit(DoLoginSuccess());
      return;
    } on Exception catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }
}
