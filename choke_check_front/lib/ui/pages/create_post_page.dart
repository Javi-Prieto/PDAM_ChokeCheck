
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:choke_check_front/blocs/post/post_bloc.dart';
import 'package:choke_check_front/data/post/repository/post_repository.dart';
import 'package:choke_check_front/data/post/repository/post_repository_imp.dart';
import 'package:choke_check_front/data/post/services/post_service.dart';
import 'package:choke_check_front/models/request/post_request.dart';
import 'package:choke_check_front/ui/pages/take_picture_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formRegister = GlobalKey<FormState>();
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();
  final train1STextController = TextEditingController();
  final train1MTextController = TextEditingController();
  final train1ETextController = TextEditingController();
  final train2STextController = TextEditingController();
  final train2MTextController = TextEditingController();
  final train2ETextController = TextEditingController();
  final train3STextController = TextEditingController();
  final train3MTextController = TextEditingController();
  final train3ETextController = TextEditingController();
  var typeColorController = 'Please select the type of Post';

  PostRepository authRepository =
      PostRepositoryImpl(postService: PostService.create());
  late PostBloc _postBloc;
  late File fileSelected = File('');

  late final List<CameraDescription> cameras;
  late final CameraDescription firstCamera;

  void pickImageBeltFile(){
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    ).then((result) {

      if (result != null) {
        fileSelected = File(result.files.first.path!);
      } else {
        print("ERROR :: Not file selected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc(authRepository)..add(PostGoFormEvent());
    availableCameras().then((value){
      cameras = value;
      firstCamera = value.first;
    });
  }

  @override
  void dispose() {
    titleTextController.dispose();
    contentTextController.dispose();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text('Create Post'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
        ),
        body: BlocConsumer<PostBloc, PostState>(
          buildWhen: (constext, state) {
            return state is CreatePostInitial ||
                state is CreatePostLoading ||
                state is CreatePostError ||
                state is PostFormClick;
          },
          builder: (context, state) {
            if (state is CreatePostInitial || state is PostFormClick) {
              return _selectForm();
            } else if (state is CreatePostLoading) {
              return const CircularProgressIndicator();
            } else if (state is CreatePostError) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  _errorMessage(state.messageError),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.canPop(context);
                    },
                    child: const Text("Back to the Form"),
                  )
                ],
              ));
            } else {
              return Text(state.toString());
            }
          },
          listenWhen: (context, state) {
            return state is CreatePostSuccess;
          },
          listener: (context, state) {
            if (state is CreatePostSuccess) {
              _postBloc.add(PostFetchEvent(pageNumber: 0));
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  _selectForm() {
    switch (typeColorController) {
      case 'Please select the type of Post':
        return _buildCreateForm();
      case 'ADVICE':
        return _buildCreateForm();
      case 'NEWS':
        return _buildCreateForm();
      case 'TRAINING':
        return _buildTrainerForm();
      default:
        return const Text('other');
    }
  }

  _buildTrainerForm() {
    final options = [
      'Please select the type of Post',
      'ADVICE',
      'TRAINING',
      'NEWS'
    ];
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.blue.shade900),
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formRegister,
              child: ListView(
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: titleTextController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Title',
                            fillColor: Colors.white,
                            filled: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train1STextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Series',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train1MTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Time',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train1ETextController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Exercise',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train2STextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Series',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train2MTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Time',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train2ETextController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Exercise',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train3STextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Series',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train3MTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Time',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: train3ETextController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Exercise',
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: const TextStyle(),
                                errorStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Please select the post type',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              value: typeColorController,
                              isDense: true,
                              onChanged: (value) {
                                setState(() {
                                  typeColorController = value!;
                                  state.didChange(value);
                                });
                              },
                              items: options.map((String e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                            )),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _buildTakePicturesPhoto(),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 7, 43, 97)),
                                elevation: MaterialStateProperty.all<double>(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            onPressed: () {
                              if (_formRegister.currentState!.validate()) {
                                String trainingContent =
                                    '${train1STextController.text}x${train1MTextController.text}min|${train1ETextController.text},${train2STextController.text}x${train2MTextController.text}min|${train2ETextController.text},${train3STextController.text}x${train3MTextController.text}min|${train3ETextController.text}';
                                PostRequest newPost = PostRequest(
                                    content: trainingContent,
                                    title: titleTextController.text,
                                    type: typeColorController);
                                _postBloc
                                    .add(CreatePostEvent(newPost: newPost, file: fileSelected));
                              }
                            },
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  _buildCreateForm() {
    final options = [
      'Please select the type of Post',
      'ADVICE',
      'TRAINING',
      'NEWS'
    ];
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.blue.shade900),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formRegister,
          child: ListView(
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Title',
                        fillColor: Colors.white,
                        filled: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: contentTextController,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Content',
                        fillColor: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select the post type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: typeColorController,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              typeColorController = value!;
                              state.didChange(value);
                            });
                          },
                          items: options.map((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                        )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _buildTakePicturesPhoto(),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 7, 43, 97)),
                            elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          if (_formRegister.currentState!.validate()) {
                            PostRequest newPost = PostRequest(
                                content: contentTextController.text,
                                title: titleTextController.text,
                                type: typeColorController);
                            _postBloc.add(CreatePostEvent(newPost: newPost, file: fileSelected));
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _errorMessage(String message) {
    if (message.contains('title')) {
      return const Text('Not valid title');
    } else if (message.contains('content')) {
      return const Text('Not valid content');
    } else if (message.contains('type')) {
      return const Text('Not valid type');
    } else {
      return const Text('Not valid data');
    }
  }

  Widget _buildTakePicturesPhoto(){
     return Column(
       children: [
         const Text('Clicking on this buttons you can upload a photo to the post, it is not obligatory but we recommend it.' , style: TextStyle(color: Colors.black),),
         Text('If you get into here after take a picture select it on the upload picture', style: TextStyle(color: Colors.grey.shade700),),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             IconButton(
                 tooltip: 'Take photo',
                 style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromARGB(255, 7, 43, 97)),
                     elevation: MaterialStateProperty.all<double>(0),
                     shape: MaterialStateProperty.all(
                         RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8)))),
                 onPressed: () {
                   Navigator.push(
                       context,
                       CupertinoPageRoute(
                           builder: (context) => TakePicturePage(camera: firstCamera)));
                 }, icon: const Icon(Icons.camera_alt, color: Colors.white, size: 50,)),
             IconButton(
                 tooltip: 'Upload photo',
                 style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromARGB(255, 7, 43, 97)),
                     elevation: MaterialStateProperty.all<double>(0),
                     shape: MaterialStateProperty.all(
                         RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8)))),
                 onPressed: pickImageBeltFile,
                 icon: const Icon(Icons.file_upload_outlined, color: Colors.white, size: 50,)),
           ],
         ),
       ],
     );
  }
}
