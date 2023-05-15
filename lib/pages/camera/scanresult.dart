import 'dart:io';
import 'package:anidex/controllers/api_controllers.dart';
import 'package:anidex/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanResult extends StatefulWidget {
  final String path;
  const ScanResult({super.key, required this.path});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> with ImageCache {
  bool isLoading = true;
  Size imageSize = const Size(0, 0);
  Future<void> detectImage() async {
    ApiControllers state = Get.find<ApiControllers>();
    if (await File(widget.path).exists()) {
      await state.detectAnimal(widget.path);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getSize() async {
    File image = File(widget.path); // Or any other way to get a File instance.
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    imageSize =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    setState(() {});
    // print(decodedImage.width);
    // print(decodedImage.height);
  }

  @override
  void initState() {
    getSize();
    detectImage();

    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // await Get.offAll(() => const HomePage());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Result"),
        ),
        body: GetBuilder<ApiControllers>(builder: (state) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.objectData.isEmpty
                  ? const Center(
                      child: Text("No Object Detected!"),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: state.objectData.length,
                              itemBuilder: (context, index) {
                                ObjectData label =
                                    state.objectData.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.pink)),
                                          child: CustomPaint(
                                            size: Size(imageSize.width,
                                                imageSize.height),
                                            foregroundPainter:
                                                RectPaint(label.poly),
                                            child: Image.file(
                                              File(widget.path),
                                              // height: 250,
                                              // width: Get.size.width * 0.95,
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            onTap: () async {
                                              Get.to(() => SearchPage(
                                                    filter: label.name,
                                                  ));
                                            },
                                            title: Text(label.name),
                                            trailing: Text(
                                                "${((label.score * 100).toStringAsFixed(2))}%"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
        }),
      ),
    );
  }
}

class RectPaint extends CustomPainter {
  List poly = [];
  RectPaint(this.poly);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    path.moveTo(size.width * poly[0]['x'], size.height * poly[0]['y']);
    for (var i = 1; i < poly.length; i++) {
      path.lineTo(size.width * poly[i]['x'], size.height * poly[i]['y']);
    }
    path.close();
    // path.moveTo(0, 0);
    // path.lineTo(80, 0);
    // path.lineTo(80, 80);
    // path.lineTo(0, 80);
    // path.lineTo(0, -2);
    // path.moveTo(size.width * x1, size.width * y1);
    // path.lineTo(size.width * x2, size.width * y2);
    // path.lineTo(size.width * x3, size.height * y3);
    // path.lineTo(size.width * x2, size.height * x2);
    // path.lineTo(size.width * x2, size.height * y3);
    // path.lineTo(size.width * x1, size.width * y3);
    // path.lineTo(size.width * x1, size.width * y1);

    // path.lineTo(80, 80);
    // path.lineTo(0, 80);
    // path.lineTo(0, -2);
    // path.lineTo(-80, 80);
    // path.lineTo(0, 80);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
