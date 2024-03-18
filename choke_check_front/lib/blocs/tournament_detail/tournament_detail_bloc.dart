import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repository.dart';
import 'package:choke_check_front/models/response/tournament_detail_response.dart';
import 'package:meta/meta.dart';

part 'tournament_detail_event.dart';
part 'tournament_detail_state.dart';

class TournamentDetailBloc
    extends Bloc<TournamentDetailEvent, TournamentDetailState> {
  final TournamentRepository repository;
  TournamentDetailBloc(this.repository) : super(TournamentDetailInitial()) {
    on<TournamentDetailFetchEvent>(_onFetch);
    on<TournamentDetailAddApplyEvent>(_onAddApply);
    on<TournamentDetailDeleteApplyEvent>(_onDeleteApply);
  }
  _onFetch(TournamentDetailFetchEvent event,
      Emitter<TournamentDetailState> emit) async {
    try {
      final response = await repository.getTournamentById(event.tournamentId);
      emit(TournamentDetailFetched(response));
      return;
    } on Exception catch (e) {
      emit(TournamentDetailFetchError(e.toString()));
    }
  }

  _onAddApply(TournamentDetailAddApplyEvent event,
      Emitter<TournamentDetailState> emit) async {
    try {
      await repository.addApply(event.id);
      emit(AddTournamentDetailApplySuccess());
      return;
    } on Exception catch (e) {
      emit(AddTournamentDetailApplyError(messageError: e.toString()));
    }
  }

  _onDeleteApply(TournamentDetailDeleteApplyEvent event,
      Emitter<TournamentDetailState> emit) async {
    try {
      await repository.deleteApply(event.id);
      emit(AddTournamentDetailApplySuccess());
      return;
    } on Exception catch (e) {
      emit(AddTournamentDetailApplyError(messageError: e.toString()));
    }
  }
}
