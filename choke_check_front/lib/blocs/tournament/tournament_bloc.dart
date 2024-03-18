import 'package:bloc/bloc.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repository.dart';
import 'package:choke_check_front/models/response/tournament_list_response/content.dart';
import 'package:meta/meta.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  final TournamentRepository repository;
  TournamentBloc(this.repository) : super(TournamentInitial()) {
    on<TournamentFetchEvent>(_onFetch);
    on<TournamentGoDetailEvent>(_onGoDetail);
    on<TournamentAddApplyEvent>(_onAddApply);
    on<TournamentDeleteApplyEvent>(_onDeleteApply);
  }
  _onFetch(TournamentFetchEvent event, Emitter<TournamentState> emit) async {
    try {
      final tournamentResponse = await repository.getAllTournament();
      emit(TournamentFetched(tournamentList: tournamentResponse.content!));
      return;
    } on Exception catch (e) {
      emit(TournamentFetchError(messageError: e.toString()));
    }
  }

  _onGoDetail(TournamentGoDetailEvent event, Emitter<TournamentState> emit) {
    try {
      emit(TournamentDetailClicked(tournamentId: event.id));
    } on Exception catch (e) {
      emit(TournamentFetchError(messageError: e.toString()));
    }
  }

  _onAddApply(
      TournamentAddApplyEvent event, Emitter<TournamentState> emit) async {
    try {
      await repository.addApply(event.id);
      emit(AddApplyTournamentSuccess());
      return;
    } on Exception catch (e) {
      emit(AddApplyTournamentError(messageError: e.toString()));
    }
  }

  _onDeleteApply(
      TournamentDeleteApplyEvent event, Emitter<TournamentState> emit) async {
    try {
      await repository.deleteApply(event.id);
      emit(AddApplyTournamentSuccess());
      return;
    } on Exception catch (e) {
      emit(AddApplyTournamentError(messageError: e.toString()));
    }
  }
}
