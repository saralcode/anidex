import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class DetectionController extends GetxController {
  ImageLabeler? imageLabeler;
  String result = "";
  List<ImageLabel> imageLabels = [];
  void initialize() {
    // FirebaseLabelerOption(modelName: modelName)
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
    imageLabels = await imageLabeler!.processImage(input);
    update();
  }
}
