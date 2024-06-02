import 'dart:io';

import 'package:camera/camera.dart';
import 'package:choke_check_front/ui/pages/upload_belt_photo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;

  const TakePicturePage({super.key, required this.camera});

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;


  @override
  void initState() {
    super.initState();

    controller = CameraController(widget.camera, ResolutionPreset.medium);

    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture'), centerTitle: true,),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await controller.takePicture();

            if (!context.mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                  camera: widget.camera,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final CameraDescription camera;
  const DisplayPictureScreen({super.key, required this.imagePath, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(child: Column(
        children: [
          Image.file(File(imagePath)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePicturePage(camera: camera),
                  ),
                );

              },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 7, 43, 97)),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))), child: const Text('Take another'),),
              TextButton(onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadBeltPhotoScreen(),
                  ),
                );

              },
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
    const Color.fromARGB(255, 7, 43, 97)),
    elevation: MaterialStateProperty.all<double>(0),
    shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8)))), child: const Text('Select the photo')),
            ],)
        ],
      )),
    );
  }
}
