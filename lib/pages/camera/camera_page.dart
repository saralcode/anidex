import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    controller = CameraController(_cameras[0], ResolutionPreset.high);
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
          : Column(
              children: [
                CameraPreview(controller),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                        heroTag: "camera",
                        backgroundColor: Colors.pink,
                        onPressed: () {},
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}
