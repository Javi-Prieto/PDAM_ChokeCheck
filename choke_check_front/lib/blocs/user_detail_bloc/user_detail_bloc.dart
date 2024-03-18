import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/user/repository/user_repository.dart';
import 'package:choke_check_front/models/response/user_detail_response/user_detail_response.dart';
import 'package:meta/meta.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository repository;

  UserDetailBloc(this.repository) : super(UserDetailInitial()) {
    on<FetchUserDetailEvent>(_onFetch);
  }
  _onFetch(FetchUserDetailEvent event, Emitter<UserDetailState> emit) async {
    try {
      final userDetailResponse =
          await repository.getUserByUsername(event.username);
      emit(UserDetailFetched(user: userDetailResponse));
      return;
    } on Exception catch (e) {
      emit(UserDetailFetchError(messageError: e.toString()));
    }
  }
}
