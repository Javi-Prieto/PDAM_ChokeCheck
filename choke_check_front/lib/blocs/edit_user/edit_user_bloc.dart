import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/user/repository/user_repository.dart';
import 'package:choke_check_front/models/request/edit_request.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserRepository repository;
  EditUserBloc(this.repository) : super(EditUserInitial()) {
    on<DoEditEvent>(_onDoEdit);
  }

  _onDoEdit(DoEditEvent event, Emitter<EditUserState> emit) async {
    emit(DoEditUserLoading());
    try {
      await repository.editUser(event.user);
      emit(DoEditUserSuccess());
      return;
    } on Exception catch (e) {
      emit(DoEditUserError(e.toString()));
    }
  }
}
