import 'dart:developer';
import 'dart:io';

import 'package:anidex/pages/camera/detection.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/// CameraApp is the Main Application.
class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> _cameras = [];
  late CameraController controller;
  bool isInitilized = false;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.medium);
    setState(() {});
    try {
      await controller.initialize();
      isInitilized = true;
      setState(() {});
    } catch (e) {
      if (e is CameraException) {
        Get.back();
        switch (e.code) {
          case 'CameraAccessDenied':
            Get.snackbar("Access Denied", "Camera Access Denied");
            break;
          default:
            Get.snackbar(e.code, "${e.description}");
            break;
        }
      }
    }
  }

  @override
  void initState() {
    Get.put(DetectionController());
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isInitilized
          ? const Center(child: CircularProgressIndicator())
          : GetBuilder<DetectionController>(builder: (state) {
              return Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: CameraPreview(controller),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton(
                                heroTag: "camera",
                                backgroundColor: Colors.pink,
                                onPressed: () async {
                                  XFile image = await controller.takePicture();

                                  File file = File(
                                      "/data/user/0/com.saralcode.anidex.anidex/cache/image.jpg");
                                  if (file.existsSync()) {
                                    file.deleteSync();
                                  }
                                  await file
                                      .writeAsBytes(await image.readAsBytes());
                                  state.labeling(file.path);
                                  await controller.resumePreview();
                                },
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              state.result,
                              textScaleFactor: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ))
                ],
              );
            }),
    );
  }
}
