import 'package:choke_check_front/models/response/tournament_detail_response.dart';
import 'package:choke_check_front/models/response/tournament_list_response/tournament_list_response.dart';

abstract class TournamentRepository {
  Future<TournamentListResponse> getAllTournament();

  Future<TournamentDetailResponse> getTournamentById(String id);

  Future<TournamentDetailResponse> addApply(String id);

  Future<dynamic> deleteApply(String id);
}
