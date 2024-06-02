import 'dart:io';

import 'package:camera/camera.dart';
import 'package:choke_check_front/blocs/belt_photo/belt_photo_bloc.dart';
import 'package:choke_check_front/data/photo/repository/photo_belt_repository.dart';
import 'package:choke_check_front/data/photo/repository/photo_belt_repository_impl.dart';
import 'package:choke_check_front/ui/pages/home_page.dart';
import 'package:choke_check_front/ui/pages/register_page.dart';
import 'package:choke_check_front/ui/pages/take_picture_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/photo/service/photo_belt_service.dart';
import 'login_page.dart';

class UploadBeltPhotoScreen extends StatefulWidget {

  const UploadBeltPhotoScreen({super.key});

  @override
  State<UploadBeltPhotoScreen> createState() => _UploadBeltPhotoScreenState();
}

class _UploadBeltPhotoScreenState extends State<UploadBeltPhotoScreen> {
  PhotoBeltRepository photoBeltRepository =
      PhotoBeltRepositoryImpl(photoBeltService: PhotoBeltService.create());
  late BeltPhotoBloc _beltPhotoBloc;
  late final List<CameraDescription> cameras;
  late final CameraDescription firstCamera;

  @override
  void initState() {
    super.initState();
    _beltPhotoBloc = BeltPhotoBloc(photoBeltRepository);
    availableCameras().then((value){
      cameras = value;
      firstCamera = value.first;
    });
  }

  void pickImageBeltFile(){
    FilePicker.platform
        .pickFiles(
      type: FileType.image,
      allowMultiple: false,
    ).then((result) {
      print("SUCCESS :: Inside");

      if (result != null) {
        File file = File(result.files.first.path!);
        print("SUCCESS :: very Inside");
        _beltPhotoBloc.add(
            ValidateBeltEvent(file: file));
        print("SUCCESS :: very very Inside");
      } else {
        print("ERROR :: Not file selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _beltPhotoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "UPLOAD YOUR BELT PHOTO",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800,
        ),
        body: BlocConsumer<BeltPhotoBloc, BeltPhotoState>(
          buildWhen: (constext, state) {
            return state is BeltPhotoInitial ||
                state is ValidateBeltLoading ||
                state is ValidateBeltError ||
                state is ValidateBeltNotTheSameError;
          },
          builder: (context, state) {
            if (state is BeltPhotoInitial) {
              return buildInitialPage(context);
            } else if (state is ValidateBeltLoading) {
              return const SafeArea(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is ValidateBeltError) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UploadBeltPhotoScreen()));
                    },
                    child: const Text("Back to the Page"),
                  )
                ],
              ));
            } else if (state is ValidateBeltNotTheSameError) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UploadBeltPhotoScreen()));
                    },
                    child: const Text("Back to the Page"),
                  )
                ],
              ));
            } else {
              return Text(state.toString());
            }
          },
          listenWhen: (context, state) {
            return state is ValidateBeltSuccess;
          },
          listener: (context, state) {
            if (state is ValidateBeltSuccess) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => RegisterPage(beltPhoto: state.belt,)));
            }
          },
        ),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }

  Widget buildInitialPage(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text(
                  'To confirm that you actually are a bjj user you may send us a photo of your belt'
              ,style: TextStyle(fontSize: 24)),
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text(
                  'If you already select a picture or take a photo just selected another time, we are working on it'
                  ,style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 140,),
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
                    }, icon: const Icon(Icons.camera_alt, color: Colors.white, size: 100,)),
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
                    icon: const Icon(Icons.file_upload_outlined, color: Colors.white, size: 100,)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Registered?',style: TextStyle(fontSize: 24),),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
