import 'package:choke_check_front/blocs/post/post_bloc.dart';
import 'package:choke_check_front/blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:choke_check_front/data/post/repository/post_repository.dart';
import 'package:choke_check_front/data/post/repository/post_repository_imp.dart';
import 'package:choke_check_front/data/post/services/post_service.dart';
import 'package:choke_check_front/data/user/repository/user_repository.dart';
import 'package:choke_check_front/data/user/repository/user_repository_impl.dart';
import 'package:choke_check_front/data/user/service/user_service.dart';
import 'package:choke_check_front/models/response/user_detail_response/post.dart';
import 'package:choke_check_front/models/response/user_detail_response/user_detail_response.dart';
import 'package:choke_check_front/ui/pages/edit_profile_page.dart';
import 'package:choke_check_front/ui/pages/initial_page.dart';
import 'package:choke_check_front/ui/pages/user_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserRepository repository =
      UserRepositoryImpl(userService: UserService.create());
  PostRepository postRepository =
      PostRepositoryImpl(postService: PostService.create());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late String loggeUserBelt;
  late String loggedUsername;
  late UserDetailBloc _userBloc;
  late PostBloc _postBloc;
  late double rate;

  @override
  void initState() {
    super.initState();

    _userBloc = UserDetailBloc(repository);
    _postBloc = PostBloc(postRepository);
  }

  Future<String> getLoggedUsername() async {
    prefs = await _prefs;
    loggedUsername = prefs.getString('username')!;
    loggeUserBelt = prefs.getString('user_belt')!;
    return prefs.getString('username')!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocProvider.value(
              value: _userBloc
                ..add(FetchUserDetailEvent(username: snapshot.data!)),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    loggedUsername.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: BlocConsumer<UserDetailBloc, UserDetailState>(
                        builder: (context, state) {
                          if (state is UserDetailInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is UserDetailFetchError) {
                            return Column(
                              children: [
                                Text(state.messageError),
                                ElevatedButton(
                                  onPressed: () {
                                    context.watch<UserDetailBloc>().add(
                                        FetchUserDetailEvent(
                                            username: loggedUsername));
                                  },
                                  child: const Text('Retry'),
                                )
                              ],
                            );
                          } else if (state is UserDetailFetched) {
                            return _onFetched(state.user);
                          } else {
                            return const Text('Not Support');
                          }
                        },
                        listener: (context, state) {})),
              ));
        } else {
          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: getLoggedUsername(),
    );
  }

  _onFetched(UserDetailResponse user) {
    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name!.toUpperCase()} ',
                        style: headerStyle,
                      ),
                      Text(
                        user.surname!.toUpperCase(),
                        style: headerStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        elevation: const MaterialStatePropertyAll(3),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      prefs.clear();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const InitialPage())));
                    },
                    child: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade300),
                        elevation: const MaterialStatePropertyAll(3),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => EditProfilePage(
                                    userDetailResponse: user,
                                  ))));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 350,
              child: Card(
                elevation: 8,
                child: Column(
                  children: [
                    const Text(
                      'BIOMETRICS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 115,
                          child: Card(
                            color: const Color.fromARGB(255, 7, 43, 97),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.fitness_center_sharp,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${user.weight!}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          height: 115,
                          child: Card(
                              color: const Color.fromARGB(255, 7, 43, 97),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.cake,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '${user.age!}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ])),
                        ),
                        SizedBox(
                          width: 90,
                          height: 115,
                          child: Card(
                            color: const Color.fromARGB(255, 7, 43, 97),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.wc,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      user.sex! == 0 ? 'Male' : 'Female',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
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
                    const SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            getImageFromBelt(user.belt!.toUpperCase()),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'POSTS',
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
            const Divider()
          ],
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: SizedBox(
                  width: 500,
                  child: Card(
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        Container(
                          height: 325,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            color: _getCardColor(user.posts![index].type!),
                          ),
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: Center(
                                  child: Text(
                                user.posts![index].type!.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              user.posts![index].title!,
                              softWrap: true,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => UserDetailPage(
                                            username: user
                                                .posts![index].authorName!)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.posts![index].authorName!
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.accessibility_new_rounded,
                                    color: _getIconColor(
                                        user.posts![index].authorBelt!),
                                  )
                                ],
                              ),
                            ),
                            Center(child: _getBody(user.posts![index])),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _getDeleteButton(user.posts![index]),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  user.posts![index].avgRate!.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                _getStarButton(user.posts![index]),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  user.posts![index].likes!.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                _getHeartButton(user.posts![index]),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 65),
            itemCount: user.posts!.length,
          ),
        ),
      ],
    );
  }

  Widget getImageFromBelt(String belt) {
    switch (belt) {
      case 'WHITE':
        return const Image(
          image: AssetImage('assets/images/white_belt.png'),
        );
      case 'BLUE':
        return const Image(image: AssetImage('assets/images/blue_belt.png'));
      case 'PURPLE':
        return const Image(image: AssetImage('assets/images/purple_belt.png'));
      case 'BROWN':
        return const Image(image: AssetImage('assets/images/brown_belt.png'));
      case 'BLACK':
        return const Image(image: AssetImage('assets/images/black_belt.png'));
      case 'RED_BLACK':
        return const Image(
            image: AssetImage('assets/images/black_red_belt.png'));
      case 'RED_WHITE':
        return const Image(
            image: AssetImage('assets/images/white_red_belt.png'));
      case 'RED':
        return const Image(
          image: AssetImage('assets/images/red_belt.png'),
        );
      default:
        return const Image(image: AssetImage('assets/images/white_belt.png'));
    }
  }

  _getHeartButton(Post post) {
    return BlocProvider.value(
      value: _postBloc,
      child: BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          if (state is AddLikeError) {
            return Column(
              children: [
                Text(state.messageError),
                ElevatedButton(
                  onPressed: () {
                    _userBloc
                        .add(FetchUserDetailEvent(username: loggedUsername));
                  },
                  child: const Text('Retry'),
                )
              ],
            );
          } else if (state is DeleteLikeError) {
            return Column(
              children: [
                Text(state.messageError),
                ElevatedButton(
                  onPressed: () {
                    _userBloc
                        .add(FetchUserDetailEvent(username: loggedUsername));
                  },
                  child: const Text('Retry'),
                )
              ],
            );
          }
          if (post.isLikedByLoggedUser!) {
            return IconButton(
                onPressed: () {
                  _postBloc.add(DeleteLikeEvent(id: post.id!));
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red.shade800,
                  size: 35,
                ));
          } else {
            return IconButton(
                onPressed: () {
                  _postBloc.add(AddLikeEvent(id: post.id!));
                },
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.black,
                  size: 35,
                ));
          }
        },
        listener: (context, state) {
          if (state is AddLikeSuccess) {
            _userBloc.add(FetchUserDetailEvent(username: loggedUsername));
          } else if (state is DeleteLikeSuccess) {
            _userBloc.add(FetchUserDetailEvent(username: loggedUsername));
          }
        },
      ),
    );
  }

  Color _getStarColor(String authorBelt, bool isRatedByLoggedUser) {
    int numberAuthorBelt = getNumberFromBelt(authorBelt);
    int numberLoggedBelt = getNumberFromBelt(loggeUserBelt);
    if (isRatedByLoggedUser) return Colors.yellow;
    if (numberLoggedBelt >= numberAuthorBelt) {
      return Colors.black;
    }
    return Colors.black;
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

  _getDeleteButton(Post post) {
    if (post.authorName! == loggedUsername) {
      return BlocProvider.value(
        value: _postBloc,
        child: BlocConsumer<PostBloc, PostState>(
          listenWhen: (context, state) {
            return state is DeletePostSuccess;
          },
          listener: (context, state) {
            if (state is DeletePostSuccess) {
              _userBloc.add(FetchUserDetailEvent(username: loggedUsername));
            } else if (state is CreateRateSuccess) {
              _postBloc.add(PostFetchEvent());
            }
          },
          builder: (context, state) {
            if (state is DeletePostError) {
              return Column(
                children: [
                  Text(state.messageError),
                  ElevatedButton(
                    onPressed: () {
                      context.watch<PostBloc>().add(PostFetchEvent());
                    },
                    child: const Text('Retry'),
                  )
                ],
              );
            }
            return IconButton(
                onPressed: () {
                  _postBloc.add(DeletePostEvent(id: post.id!));
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.black,
                ));
          },
        ),
      );
    }
    return const Icon(
      Icons.delete_forever_rounded,
      color: Colors.black,
    );
  }

  _getBody(Post post) {
    switch (post.type) {
      case 'TRAINING':
        List<String> training = post.content!.split(',');
        return Container(
            width: 325,
            padding: const EdgeInsets.all(20.0),
            child: _getTrainingBody(training));
      case 'ADVICE':
        return Container(
          alignment: Alignment.center,
          height: 150,
          child: Text(
            '"${post.content!.toUpperCase()}"',
            softWrap: true,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                shadows: [
                  Shadow(
                      color: Colors.black, blurRadius: 7, offset: Offset(2, 2)),
                ],
                fontStyle: FontStyle.italic),
          ),
        );
      case 'NEWS':
        return Container(
            alignment: Alignment.center,
            height: 150,
            child: Text(post.content!,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                )));
      default:
        return Colors.grey;
    }
  }

  _getTrainingBody(List<String> training) {
    List<Widget> list = [];

    TextStyle textStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    for (var row in training) {
      list.add(Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.split('x')[1].split('|')[1],
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            row.split('x')[0],
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            'x',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            row.split('x')[1].split('|')[0],
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ],
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: list,
    );
  }

  _getIconColor(String belt) {
    switch (belt) {
      case 'WHITE':
        return Colors.black;
      case 'BLUE':
        return Colors.blue.shade600;
      case 'PURPLE':
        return Colors.purple;
      case 'BROWN':
        return Colors.brown;
      case 'BLACK':
        return Colors.black;
      case 'RED_BLACK':
        return Colors.red.shade900;
      case 'RED_WHITE':
        return Colors.red.shade300;
      case 'RED':
        return Colors.redAccent.shade700;
      default:
        return Colors.grey;
    }
  }

  _getCardColor(String type) {
    switch (type) {
      case 'TRAINING':
        return const Color.fromRGBO(214, 246, 255, 1);
      case 'ADVICE':
        return const Color.fromRGBO(252, 174, 126, 1);
      case 'NEWS':
        return const Color.fromRGBO(250, 145, 152, 1);
      default:
        return Colors.grey;
    }
  }

  _getStarButton(Post post) {
    return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Rate this Post'),
                content: RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  glow: true,
                  wrapAlignment: WrapAlignment.center,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.yellow,
                    ),
                    empty: const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                    ),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    rate = rating;
                  },
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.black),
                        backgroundColor: Colors.black),
                    child: const Text(
                      'Rate',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      _postBloc.add(CreateRatePostEvent(post.id!, rate: rate));
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Exit'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.star_rounded,
          color: _getStarColor(post.authorBelt!, post.isRatedByLoggedUser!),
          size: 35,
        ));
  }
}
