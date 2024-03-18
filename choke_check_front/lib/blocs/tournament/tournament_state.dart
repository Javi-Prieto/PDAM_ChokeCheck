part of 'tournament_bloc.dart';

@immutable
sealed class TournamentState {}

final class TournamentInitial extends TournamentState {}

final class TournamentFetched extends TournamentState {
  final List<Content> tournamentList;

  TournamentFetched({required this.tournamentList});
}

final class TournamentFetchError extends TournamentState {
  final String messageError;

  TournamentFetchError({required this.messageError});
}

final class TournamentDetailClicked extends TournamentState {
  final String tournamentId;

  TournamentDetailClicked({required this.tournamentId});
}

final class AddApplyTournamentSuccess extends TournamentState {}

final class AddApplyTournamentError extends TournamentState {
  final String messageError;

  AddApplyTournamentError({required this.messageError});
}

final class DeleteApplyTournamentSuccess extends TournamentState {}

final class DeleteApplyTournamentError extends TournamentState {
  final String messageError;

  DeleteApplyTournamentError({required this.messageError});
}
