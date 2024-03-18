import 'package:choke_check_front/blocs/tournament/tournament_bloc.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repository.dart';
import 'package:choke_check_front/data/tournament/repository/tournament_repostory_impl.dart';
import 'package:choke_check_front/data/tournament/service/tournament_service.dart';
import 'package:choke_check_front/models/response/tournament_list_response/content.dart';
import 'package:choke_check_front/ui/pages/tournament_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  TournamentRepository repository =
      TournamentRepositoryImpl(service: TournamentService.create());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late String loggedUserName;
  late String loggeUserBelt;
  late TournamentBloc _tournamentBloc;

  @override
  void initState() {
    super.initState();
    _tournamentBloc = TournamentBloc(repository)..add(TournamentFetchEvent());
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<TournamentBloc, TournamentState>(
            buildWhen: (previous, current) {
              return current is! TournamentDetailClicked ||
                  current is! AddApplyTournamentSuccess ||
                  current is! DeleteApplyTournamentSuccess;
            },
            builder: (context, state) {
              if (state is TournamentInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TournamentFetchError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentFetchEvent());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is TournamentFetched) {
                return _onFetched(state.tournamentList);
              } else if (state is AddApplyTournamentError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentFetchEvent());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is DeleteApplyTournamentError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _tournamentBloc.add(TournamentFetchEvent());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else {
                return const Text('Not Support');
              }
            },
            listenWhen: (previous, current) {
              return current is TournamentDetailClicked ||
                  current is AddApplyTournamentSuccess;
            },
            listener: (context, state) {
              if (state is TournamentDetailClicked) {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  _tournamentBloc.add(TournamentFetchEvent());
                  return TournamentDetailPage(id: state.tournamentId);
                }));
              } else if (state is AddApplyTournamentSuccess) {
                _tournamentBloc.add(TournamentFetchEvent());
              } else if (state is DeleteApplyTournamentSuccess) {
                _tournamentBloc.add(TournamentFetchEvent());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _onFetched(List<Content> tournamentList) {
    const headerStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white);
    if (tournamentList.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: tournamentList.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                _tournamentBloc.add(
                    TournamentGoDetailEvent(id: tournamentList[index].id!));
              },
              child: SizedBox(
                child: Card(
                  color: Colors.grey.shade100,
                  child: Container(
                    height: 250,
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 270,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                tournamentList[index].title!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 260,
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      minHeight: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      value: tournamentList[index].applied! /
                                          tournamentList[index].participants!,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          tournamentList[index].applied! /
                                                      tournamentList[index]
                                                          .participants! *
                                                      100 >
                                                  50
                                              ? Colors.redAccent.shade700
                                              : Colors.greenAccent.shade700),
                                    ),
                                  ),
                                  Text(
                                    '${tournamentList[index].applied!} / ${tournamentList[index].participants!}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 115,
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 7, 43, 97),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.fitness_center_sharp,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '${tournamentList[index].minWeight!}-${tournamentList[index].maxWeight!}',
                                            style: headerStyle,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    height: 115,
                                    child: Card(
                                        color: const Color.fromARGB(
                                            255, 7, 43, 97),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(
                                                Icons.monetization_on_rounded,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                tournamentList[index].prize! ==
                                                        0
                                                    ? 'No prize'
                                                    : '${tournamentList[index].prize!}€',
                                                style: headerStyle,
                                                textAlign: TextAlign.center,
                                              )
                                            ])),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    height: 115,
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 7, 43, 97),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.access_alarm_rounded,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                tournamentList[index]
                                                    .date!
                                                    .split(' ')[0],
                                                style: headerStyle,
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                tournamentList[index]
                                                    .date!
                                                    .split(' ')[1],
                                                style: headerStyle,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                  child:
                                      _getApplyButton(tournamentList[index])),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        getImageFromBelt(tournamentList[index].higherBelt!)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }));
    } else {
      return const Center(
          child: Text(
        'No Tournaments available for you right now',
        softWrap: true,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ));
    }
  }

  Widget getImageFromBelt(String belt) {
    switch (belt) {
      case 'WHITE':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(
              image: AssetImage('assets/images/white_belt.png'),
            ));
      case 'BLUE':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(image: AssetImage('assets/images/blue_belt.png')));
      case 'PURPLE':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(image: AssetImage('assets/images/purple_belt.png')));
      case 'BROWN':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(image: AssetImage('assets/images/brown_belt.png')));
      case 'BLACK':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(image: AssetImage('assets/images/black_belt.png')));
      case 'RED_BLACK':
        return const RotatedBox(
            quarterTurns: -1,
            child:
                Image(image: AssetImage('assets/images/black_red_belt.png')));
      case 'RED_WHITE':
        return const RotatedBox(
            quarterTurns: -1,
            child:
                Image(image: AssetImage('assets/images/white_red_belt.png')));
      case 'RED':
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(
              image: AssetImage('assets/images/red_belt.png'),
            ));
      default:
        return const RotatedBox(
            quarterTurns: -1,
            child: Image(image: AssetImage('assets/images/white_belt.png')));
    }
  }

  _getApplyButton(Content tournament) {
    if (tournament.isAppliedByLoggedUser!) {
      return SizedBox(
        width: 200,
        height: 35,
        child: TextButton(
          onPressed: () {
            _tournamentBloc.add(TournamentDeleteApplyEvent(id: tournament.id!));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
              elevation: MaterialStateProperty.all<double>(10)),
          child: const Text(
            'Withdraw my Application',
            style: TextStyle(color: Colors.white),
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
                    .add(TournamentAddApplyEvent(id: tournament.id!));
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 41, 109, 211)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                elevation: MaterialStateProperty.all<double>(5),
                shadowColor: MaterialStateProperty.all(Colors.black)),
            child: getButtonText(tournament)),
      );
    }
  }

  Text getButtonText(Content tournament) {
    if (getNumberFromBelt(tournament.higherBelt!) <
        getNumberFromBelt(loggeUserBelt)) {
      return const Text(
        'Too much level',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        'Apply ${tournament.cost! == 0 ? 'For Free' : 'for ${tournament.cost!}€'}',
        style: const TextStyle(color: Colors.white),
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
