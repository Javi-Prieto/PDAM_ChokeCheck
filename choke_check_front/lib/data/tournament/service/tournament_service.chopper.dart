// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TournamentService extends TournamentService {
  _$TournamentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TournamentService;

  @override
  Future<Response<dynamic>> getAllTournaments() {
    final Uri $url = Uri.parse('tournament');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTournamentById(String id) {
    final Uri $url = Uri.parse('tournament/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addApply(String id) {
    final Uri $url = Uri.parse('tournament/apply/${id}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteApply(String id) {
    final Uri $url = Uri.parse('tournament/apply/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
