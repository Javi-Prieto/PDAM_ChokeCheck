import 'package:choke_check_front/blocs/tournament_detail/tournament_detail_bloc.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repository.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repostory_impl.dart';
import 'package:choke_check_front/data/tournament/service/tournament_service.dart';
import 'package:choke_check_front/models/response/tournament_detail_response.dart';
import 'package:choke_check_front/ui/widgets/place_maker_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TournamentDetailPage extends StatefulWidget {
  const TournamentDetailPage({super.key, required this.id});
  final String id;
  @override
  State<TournamentDetailPage> createState() => _TournamentDetailPageState();
}

class _TournamentDetailPageState extends State<TournamentDetailPage> {
  TournamentRepository repository =
      TournamentRepositoryImpl(service: TournamentService.create());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late TournamentDetailBloc _tournamentBloc;

  late SharedPreferences prefs;
  late String loggedUserName;
  late String loggeUserBelt;

  @override
  void initState() {
    super.initState();
    _tournamentBloc = TournamentDetailBloc(repository)
      ..add(TournamentDetailFetchEvent(tournamentId: widget.id));
    getLoggedUsername();
  }

  getLoggedUsername() async {
    prefs = await _prefs;
    loggedUserName = prefs.getString('username')!;
    loggeUserBelt = prefs.getString('user_belt')!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _tournamentBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<TournamentDetailBloc, TournamentDetailState>(
            builder: (context, state) {
              if (state is TournamentDetailFetched) {
                return _onFetched(state.tournament);
              } else if (state is TournamentDetailFetchError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentDetailFetchEvent(
                            tournamentId: widget.id));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is AddTournamentDetailApplyError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentDetailFetchEvent(
                            tournamentId: widget.id));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is DeleteTournamentDetailApplyError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentDetailFetchEvent(
                            tournamentId: widget.id));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else {
                return const Text('Not supported operation');
              }
            },
            listener: (context, state) {
              if (state is AddTournamentDetailApplySuccess) {
                _tournamentBloc
                    .add(TournamentDetailFetchEvent(tournamentId: widget.id));
              } else if (state is DeleteTournamentDetailApplySuccess) {
                _tournamentBloc
                    .add(TournamentDetailFetchEvent(tournamentId: widget.id));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _onFetched(TournamentDetailResponse tournament) {
    final weightInDate =
        '${tournament.date!.split(' ')[0]} ${int.parse(tournament.date!.split(' ')[1].split(':')[0]) - 1}:${tournament.date!.split(' ')[1].split(':')[1]}';
    const headerStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35);
    const textStyle = TextStyle(color: Colors.black, fontSize: 18);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Text(
            tournament.title!,
            style: headerStyle,
            textAlign: TextAlign.center,
          ),
          PlaceMarkerItem(lat: tournament.lat!, lon: tournament.lon!),
          Text(
            tournament.city!,
            style: textStyle,
          ),
          const Text(
            'Description',
            style: headerStyle,
          ),
          Text(
            tournament.content!,
            style: textStyle,
          ),
          const Divider(),
          const Text(
            'Info',
            style: headerStyle,
          ),
          Text(
            '${tournament.minWeight!}-${tournament.maxWeight!} Kg ~~ Below ${tournament.higherBelt!.toLowerCase()} belt',
            style: textStyle,
          ),
          const Divider(),
          const Text(
            'Date',
            style: headerStyle,
          ),
          Text(
            'WEIGHT IN ~ $weightInDate',
            style: textStyle,
          ),
          Text(
            'START AT ~ ${tournament.date!}',
            style: textStyle,
          ),
          Text(
            'PRIZE ~ ${tournament.prize!}',
            style: textStyle,
          ),
          const Divider(),
          Center(child: _getApplyButton(tournament)),
        ],
      ),
    );
  }

  _getApplyButton(TournamentDetailResponse tournament) {
    if (tournament.isAppliedByLoggedUser!) {
      return SizedBox(
        width: 200,
        height: 35,
        child: TextButton(
          onPressed: () {
            _tournamentBloc
                .add(TournamentDetailDeleteApplyEvent(id: widget.id));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text(
            'Withdraw my Application',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 150,
        height: 35,
        child: TextButton(
            onPressed: () {
              if (getNumberFromBelt(tournament.higherBelt!) <=
                  getNumberFromBelt(loggeUserBelt)) {
                _tournamentBloc
                    .add(TournamentDetailAddApplyEvent(id: widget.id));
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 7, 43, 97)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
            child: getButtonText(tournament)),
      );
    }
  }

  Text getButtonText(TournamentDetailResponse tournament) {
    if (getNumberFromBelt(tournament.higherBelt!) <
        getNumberFromBelt(loggeUserBelt)) {
      return const Text(
        'Too much level',
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text(
        'Apply ${tournament.cost! == 0 ? 'For Free' : 'for ${tournament.cost!}€'}',
        style: const TextStyle(color: Colors.black),
      );
    }
  }

  int getNumberFromBelt(String belt) {
    switch (belt) {
      case 'WHITE':
        return 0;
      case 'BLUE':
        return 1;
      case 'PURPLE':
        return 2;
      case 'BROWN':
        return 3;
      case 'BLACK':
        return 4;
      case 'RED_BLACK':
        return 5;
      case 'RED_WHITE':
        return 6;
      case 'RED':
        return 7;
      default:
        return -1;
    }
  }
}
