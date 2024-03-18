part of 'tournament_bloc.dart';

@immutable
sealed class TournamentEvent {}

final class TournamentFetchEvent extends TournamentEvent {}

final class TournamentGoDetailEvent extends TournamentEvent {
  final String id;

  TournamentGoDetailEvent({required this.id});
}

final class TournamentAddApplyEvent extends TournamentEvent {
  final String id;

  TournamentAddApplyEvent({required this.id});
}

final class TournamentDeleteApplyEvent extends TournamentEvent {
  final String id;

  TournamentDeleteApplyEvent({required this.id});
}
