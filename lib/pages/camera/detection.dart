import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class DetectionController extends GetxController {
  ImageLabeler? imageLabeler;
  String result = "";
  void initialize() {
    final imageLabelerOption = ImageLabelerOptions(confidenceThreshold: 0.5);
    imageLabeler = ImageLabeler(options: imageLabelerOption);
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> labeling(String path) async {
    InputImage input = InputImage.fromFilePath(path);
    final List<ImageLabel> labels = await imageLabeler!.processImage(input);
    result = "";
    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      result += "$text : ${confidence.toPrecision(2)} \n";
    }
    log(result);
    update();
  }
}
