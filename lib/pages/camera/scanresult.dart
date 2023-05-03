import 'package:anidex/pages/camera/detection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ScanResult extends StatefulWidget {
  const ScanResult({super.key});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: GetBuilder<DetectionController>(builder: (state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.imageLabels.length,
            itemBuilder: (context, index) {
              ImageLabel label = state.imageLabels.elementAt(index);
              return Card(
                child: ListTile(
                  title: Text(label.label),
                  trailing: Text((label.confidence * 100).toStringAsFixed(2)),
                ),
              );
            });
      }),
    );
  }
}
