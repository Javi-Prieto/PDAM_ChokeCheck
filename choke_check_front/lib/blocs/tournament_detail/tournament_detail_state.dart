part of 'tournament_detail_bloc.dart';

@immutable
sealed class TournamentDetailState {}

final class TournamentDetailInitial extends TournamentDetailState {}

final class TournamentDetailFetched extends TournamentDetailState {
  final TournamentDetailResponse tournament;
  TournamentDetailFetched(this.tournament);
}

final class TournamentDetailFetchError extends TournamentDetailState {
  final String messageError;
  TournamentDetailFetchError(this.messageError);
}

final class AddTournamentDetailApplySuccess extends TournamentDetailState {}

final class AddTournamentDetailApplyError extends TournamentDetailState {
  final String messageError;

  AddTournamentDetailApplyError({required this.messageError});
}

final class DeleteTournamentDetailApplySuccess extends TournamentDetailState {}

final class DeleteTournamentDetailApplyError extends TournamentDetailState {
  final String messageError;

  DeleteTournamentDetailApplyError({required this.messageError});
}
