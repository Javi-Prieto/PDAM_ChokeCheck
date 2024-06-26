import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:choke_check_front/blocs/post/post_bloc.dart';
import 'package:choke_check_front/data/post/repository/post_repository.dart';
import 'package:choke_check_front/data/post/repository/post_repository_imp.dart';
import 'package:choke_check_front/data/post/services/post_service.dart';
import 'package:choke_check_front/models/response/post_list_response/content.dart';
import 'package:choke_check_front/ui/pages/create_post_page.dart';
import 'package:choke_check_front/ui/pages/user_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostRepository repository =
      PostRepositoryImpl(postService: PostService.create());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late String loggedUserName;
  late String loggeUserBelt;
  late PostBloc _postBloc;
  late double rate;
  final ScrollController controller = ScrollController();
  int pageNumber = 0;
  List<Content> postList = [];
  int indexOfClicked = 3;

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc(repository)..add(PostFetchEvent(pageNumber: 0));
    getLoggedUsername();
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  jumpTo(){
    Timer(Duration(milliseconds: 500), (){
      controller.animateTo(150 * indexOfClicked.toDouble(), duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }
  getLoggedUsername() async {
    prefs = await _prefs;
    loggedUserName = prefs.getString('username')!;
    loggeUserBelt = prefs.getString('user_belt')!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc..add(PostFetchEvent(pageNumber: 0)),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:
                BlocConsumer<PostBloc, PostState>(buildWhen: (context, state) {
                  return state is !PostFormClick ||
                      state is !DeletePostSuccess ||
                      state is !CreateRateSuccess ||
                      state is !AddLikeSuccess ||
                      state is !DeleteLikeSuccess;
            },
                    builder: (context, state) {
              if (state is PostInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostFetchError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _postBloc.add(PostFetchEvent(pageNumber: 0));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is DeletePostError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _postBloc.add(PostFetchEvent(pageNumber: 0));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is CreateRateError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _postBloc.add(PostFetchEvent(pageNumber: 0));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is AddLikeError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        _postBloc.add(PostFetchEvent(pageNumber: 0));
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
                        _postBloc.add(PostFetchEvent(pageNumber: 0));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is PostFetched) {
                for(Content post in state.postList){
                  if(!postList.map((post)=> post.id).contains(post.id)) {
                    postList.add(post);
                  }else{
                    postList[state.postList.indexOf(post)] = state.postList[state.postList.indexOf(post)];
                  }
                }
                return _onFetched();
              } else {
                return const Text('Not Support');
              }
            }, listenWhen: (context, state) {
              return state is PostFormClick ||
                  state is DeletePostSuccess ||
                  state is CreateRateSuccess ||
                  state is AddLikeSuccess ||
                  state is DeleteLikeSuccess;
            }, listener: (context, state) {
              if (state is PostFormClick) {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CreatePostPage()));
              } else if (state is DeletePostSuccess) {
                _postBloc.add(PostFetchEvent(pageNumber: 0));
              } else if (state is AddLikeSuccess) {
                _postBloc.add(PostFetchEvent(pageNumber: 0));
              } else if (state is CreateRateSuccess) {
                _postBloc.add(PostFetchEvent(pageNumber: 0));
              } else if (state is DeleteLikeSuccess) {
                _postBloc.add(PostFetchEvent(pageNumber: 0));
              }
            }),
          )),
    );
  }

  void attachListController(){
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset){
        pageNumber ++;
        _postBloc.add(PostFetchEvent(pageNumber: pageNumber));
      }
    });
  }

  _onFetched() {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
                onPressed: () {
                  _postBloc.add(PostGoFormEvent());
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade900),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)))),
                child: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 35,
                ))),
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemBuilder: (BuildContext context, index) {
              attachListController();
              if(index < postList.length){
                if(postList[index].image!.isNotEmpty){
                  return ImagePost(
                      getCardColor: _getCardColor,
                      getIconColor: _getIconColor,
                      getBody: _getBody,
                      getDeleteButton: _getDeleteButton,
                      getStarButton: _getStarButton,
                      getHeartButton: _getHeartButton,
                      post: postList[index],
                      index: index);
                }
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
                              color: _getCardColor(postList[index].type!),
                            ),
                            child: RotatedBox(
                                quarterTurns: -1,
                                child: Center(
                                    child: Text(
                                      postList[index].type!.toUpperCase(),
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
                                postList[index].title!,
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => UserDetailPage(
                                              username:
                                              postList[index].authorName!)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      postList[index].authorName!.toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.accessibility_new_rounded,
                                      color: _getIconColor(
                                          postList[index].authorBelt!),
                                    )
                                  ],
                                ),
                              ),
                              Center(child: _getBody(postList[index])),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _getDeleteButton(postList[index]),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    postList[index].avgRate!.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  _getStarButton(postList[index], index),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    postList[index].likes!.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  _getHeartButton(postList[index], index),
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
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator(color: Colors.blue.shade800,),),
                );
              }

            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 65),
            itemCount: postList.length + 1,
          ),
        ),
      ],
    );

  }

  _getHeartButton(Content post, int index) {
    if (post.isLikedByLoggedUser!) {
      return IconButton(
          onPressed: () {
            indexOfClicked = index;
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
            indexOfClicked = index;
            _postBloc.add(AddLikeEvent(id: post.id!));
          },
          icon: const Icon(
            Icons.favorite_rounded,
            color: Colors.white,
            size: 35,
          ));
    }
  }

  Color _getStarColor(String authorBelt, bool isRatedByLoggedUser) {
    int numberAuthorBelt = getNumberFromBelt(authorBelt);
    int numberLoggedBelt = getNumberFromBelt(loggeUserBelt);
    if (isRatedByLoggedUser) return Colors.yellow;
    if (numberLoggedBelt >= numberAuthorBelt) {
      return Colors.white;
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

  _getDeleteButton(Content post) {
    if (post.authorName! == loggedUserName) {
      return IconButton(
          onPressed: () {
            _postBloc.add(DeletePostEvent(id: post.id!));
          },
          icon: const Icon(
            Icons.delete_forever_rounded,
            color: Colors.white,
          ));
    }
    return const SizedBox();
  }

  Widget _getBody(Content post) {
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
          width: 325,
          child: Text(
            '"${post.content!.toUpperCase()}"',
            softWrap: true,

            style: const TextStyle(
                fontSize: 20,
                overflow: TextOverflow.clip,
                shadows: [
                  Shadow(
                      color: Colors.black, blurRadius: 7, offset: Offset(1, 1),),
                ],
                fontStyle: FontStyle.italic),
          ),
        );
      case 'NEWS':
        return Container(
            alignment: Alignment.center,
            height: 150,
            width: 325,
            child: Text(post.content!,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 20,
                )));
      default:
        return Container();
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
        return Colors.white;
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

  _getStarButton(Content post, int index) {
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
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.black),
                  child: const Text(
                    'Rate',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    indexOfClicked = index;
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
      ),
    );
  }
}

class ImagePost extends StatefulWidget {
  final Function(String post) getCardColor;
  final Function(String post) getIconColor;
  final Function(Content post) getBody;
  final Function(Content post) getDeleteButton;
  final Function(Content post, int index) getStarButton;
  final Function(Content post, int index) getHeartButton;
  final Content post;
  final int index;

  const ImagePost({super.key, required this.getCardColor, required this.getIconColor, required this.getBody, required this.getDeleteButton, required this.getStarButton, required this.getHeartButton, required this.post, required this.index});

  @override
  State<ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  late Image image;
  double containerHeight = 325;
  bool isDescriptionVisible = false;

  @override
  void initState() {
    final bytes = base64Decode(widget.post.image!);
    image = Image.memory(
        bytes,
      fit: BoxFit.fill,
      width: 200,
      height: 150,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Card(
          color: Colors.grey.shade100,
          child: Row(
            children: [
              Container(
                height: containerHeight,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  color: widget.getCardColor(widget.post.type!),
                ),
                child: RotatedBox(
                    quarterTurns: -1,
                    child: Center(
                        child: Text(
                          widget.post.type!.toUpperCase(),
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
                    widget.post.title!,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UserDetailPage(
                                  username:
                                  widget.post.authorName!)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.post.authorName!.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.accessibility_new_rounded,
                          color: widget.getIconColor(
                              widget.post.authorBelt!),
                        )
                      ],
                    ),
                  ),
                  Center(child: image),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        setState(() {
                          containerHeight = containerHeight == 430? 325 : 430;
                          isDescriptionVisible = isDescriptionVisible?false:true;
                        });
                      }, child: const Text('See description[...]')),
                      widget.getDeleteButton(widget.post),
                      Text(
                        widget.post.avgRate!.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      widget.getStarButton(widget.post, widget.index),
                      Text(
                        widget.post.likes!.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      widget.getHeartButton(widget.post, widget.index),
                    ],
                  ),
                  Visibility(
                      visible: isDescriptionVisible,
                      child: Column(children: [
                        const SizedBox(
                        height: 25,
                      ),
                        widget.getBody(widget.post)
                      ],
                      )
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

  }
}

