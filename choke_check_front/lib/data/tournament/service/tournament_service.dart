import 'package:choke_check_front/data/interceptors/my_header_interceptor.dart';
import 'package:chopper/chopper.dart';
part 'tournament_service.chopper.dart';

@ChopperApi()
abstract class TournamentService extends ChopperService {
  static TournamentService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('http://18.171.149.35:8080/'),
      services: [_$TournamentService()],
      interceptors: [MyHeaderInterceptor()],
      converter: JsonConverter(),
    );
    return _$TournamentService(client);
  }

  @Get(path: 'tournament')
  Future<Response> getAllTournaments();

  @Get(path: 'tournament/{id}')
  Future<Response> getTournamentById(@Path() String id);

  @Post(path: 'tournament/apply/{id}')
  Future<Response> addApply(@Path() String id);

  @Delete(path: 'tournament/apply/{id}')
  Future<Response> deleteApply(@Path() String id);
}
