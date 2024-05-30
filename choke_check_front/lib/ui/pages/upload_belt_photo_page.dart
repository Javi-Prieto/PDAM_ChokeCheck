
import 'dart:io';

import 'package:choke_check_front/blocs/belt_photo/belt_photo_bloc.dart';
import 'package:choke_check_front/data/photo/repository/photo_belt_repository.dart';
import 'package:choke_check_front/data/photo/repository/photo_belt_repository_impl.dart';
import 'package:choke_check_front/ui/pages/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/photo/service/photo_belt_service.dart';

class UploadBeltPhotoScreen extends StatefulWidget {
  final String beltSelected;

  const UploadBeltPhotoScreen({super.key, required this.beltSelected});


  @override
  State<UploadBeltPhotoScreen> createState() => _UploadBeltPhotoScreenState();
}

class _UploadBeltPhotoScreenState extends State<UploadBeltPhotoScreen> {
  PhotoBeltRepository photoBeltRepository = PhotoBeltRepositoryImpl(photoBeltService: PhotoBeltService.create());
  late BeltPhotoBloc _beltPhotoBloc;

  @override
  void initState() {
    super.initState();
    _beltPhotoBloc = BeltPhotoBloc(photoBeltRepository);
  }

  void pickImageBeltFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if(result != null){
      File file = File(result.files.first.path!);
    }else{
      print("Not file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _beltPhotoBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "UPLOAD YOUR BELT PHOTO",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
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
              return buildInitialPage();
            } else if (state is ValidateBeltLoading) {
              return const SafeArea(child: Center(child: CircularProgressIndicator()));
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
                                  builder: (context) => UploadBeltPhotoScreen(beltSelected: widget.beltSelected)));
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
                                  builder: (context) => UploadBeltPhotoScreen(beltSelected: widget.beltSelected)));
                        },
                        child: const Text("Back to the Page"),
                      )
                    ],
                  ));
            }else {
              return Text(state.toString());
            }
          },
          listenWhen: (context, state) {
            return state is ValidateBeltSuccess;
          },
          listener: (context, state) {
            if (state is ValidateBeltSuccess) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const HomePage()));
            }
          },
        ),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }
  
  Widget buildInitialPage(){
    return SafeArea(
        child: Center(
          child: Row(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.camera_alt)),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.file_upload_outlined)),
            ],
          ),
        ),
      );
  }
}
