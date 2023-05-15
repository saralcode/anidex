import 'dart:io';

import 'package:anidex/pages/camera/scanresult.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras[0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);

      XFile image = await _cameraController.takePicture();
      File file =
          File("/data/user/0/com.saralcode.anidex.anidex/cache/image.jpg");
      await FileImage(File(file.path)).evict();
      if (file.existsSync()) {
        file.deleteSync();
      }
      await file.writeAsBytes(await image.readAsBytes());

      await Get.to(() => ScanResult(path: file.path));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Take a Picture"),
        ),
        body: SafeArea(
          child: Stack(children: [
            (_cameraController.value.isInitialized)
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: CameraPreview(_cameraController)),
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(child: CircularProgressIndicator())),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.white),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.white,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                                _isRearCameraSelected
                                    ? Icons.camera_front
                                    : Icons.camera_rear,
                                color: Colors.blue),
                            onPressed: () {
                              setState(() => _isRearCameraSelected =
                                  !_isRearCameraSelected);
                              initCamera(widget
                                  .cameras[_isRearCameraSelected ? 0 : 1]);
                            },
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: Container(
                            height: 60,
                            margin: const EdgeInsets.all(10),
                            width: 60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.pink),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                              hoverColor: Colors.pink,
                              focusColor: Colors.pink,
                              onPressed: takePicture,
                              iconSize: 50,
                              splashRadius: 38,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon:
                                  const Icon(Icons.circle, color: Colors.blue),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Material(
                          color: Colors.white,
                          child: IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  Get.to(() => ScanResult(
                                      path: result.files.first.path!));
                                }
                              },
                              icon: const Icon(
                                Icons.photo_album,
                                color: Colors.pink,
                              )),
                        )
                      ]),
                )),
          ]),
        ));
  }
}



/*


*/