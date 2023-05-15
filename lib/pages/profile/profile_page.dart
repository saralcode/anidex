import 'package:anidex/controllers/api_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  final int index;
  const ProfilePage({super.key, required this.index});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiControllers>(builder: (state) {
      Animal animal = state.animals.elementAt(widget.index);
      return Scaffold(
        appBar: AppBar(
          title: Text(animal.name),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  animal.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Markdown(
              data: animal.content,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            )
          ],
        ),
      );
    });
  }
}
