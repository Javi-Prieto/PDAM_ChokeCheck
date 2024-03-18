part of 'tournament_detail_bloc.dart';

@immutable
sealed class TournamentDetailEvent {}

final class TournamentDetailFetchEvent extends TournamentDetailEvent {
  final String tournamentId;

  TournamentDetailFetchEvent({required this.tournamentId});
}

final class TournamentDetailAddApplyEvent extends TournamentDetailEvent {
  final String id;

  TournamentDetailAddApplyEvent({required this.id});
}

final class TournamentDetailDeleteApplyEvent extends TournamentDetailEvent {
  final String id;

  TournamentDetailDeleteApplyEvent({required this.id});
}
