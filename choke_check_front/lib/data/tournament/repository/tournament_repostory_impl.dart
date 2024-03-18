import 'package:choke_check_front/data/tournament/repository/tournament_repository.dart';
import 'package:choke_check_front/data/tournament/service/tournament_service.dart';
import 'package:choke_check_front/models/response/tournament_detail_response.dart';
import 'package:choke_check_front/models/response/tournament_list_response/tournament_list_response.dart';

class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentService service;

  TournamentRepositoryImpl({required this.service});

  @override
  Future<TournamentListResponse> getAllTournament() async {
    final response = await service.getAllTournaments();
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return TournamentListResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<TournamentDetailResponse> getTournamentById(String id) async {
    final response = await service.getTournamentById(id);
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return TournamentDetailResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future<TournamentDetailResponse> addApply(String id) async {
    final response = await service.addApply(id);
    if (response.isSuccessful) {
      if (response.bodyString.isEmpty) {
        throw Exception('Not valid token');
      } else {
        return TournamentDetailResponse.fromJson(response.bodyString);
      }
    } else {
      throw Exception(response.error);
    }
  }

  @override
  Future deleteApply(String id) async {
    final response = await service.deleteApply(id);
    if (response.isSuccessful) {
      return 'all correct';
    } else {
      throw Exception(response.error);
    }
  }
}
