import 'package:anidex/pages/camera/camera_page.dart';
import 'package:anidex/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("AniDex"),
          actions: [
            FloatingActionButton.small(
                heroTag: "search",
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.to(() => const SearchPage());
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.pink,
                )),
            FloatingActionButton.small(
                heroTag: "camera",
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.to(() => const CameraPage());
                },
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.purple,
                )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.blue])),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          "https://images.unsplash.com/photo-1590434972117-eaac0c4b193e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Wrap(
                        clipBehavior: Clip.antiAlias,
                        runAlignment: WrapAlignment.start,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: 10,
                        children: [
                          const Text(
                            "Animal of the Day",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decorationStyle: TextDecorationStyle.wavy,
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Bear",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "serif",
                                fontSize: 20,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: Get.size.width - 180,
                            child: const Text(
                              "Mollit consequat sint magna irure mollit qui consequat mollit. Amet non proident culpa non do laboris enim dolore irure dolor eiusmod ea proident.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Articles",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            for (int i = 0; i < 20; i++)
              Card(
                child: ListTile(
                  onTap: () {},
                  minVerticalPadding: 10,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1591824438708-ce405f36ba3d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: const Text(
                    "Quis quis exercitation officia eu ullamco elit tempor cillum proident culpa ut nostrud sit.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: const Text(
                    "Proident esse enim ullamco sint. Reprehenderit consequat voluptate aliquip minim amet duis. Veniam sint elit irure ea cillum magna exercitation commodo sit velit amet. Amet aliquip ipsum quis nisi ex dolore laboris fugiat. Commodo quis nostrud nostrud ex ut est enim duis proident non veniam sunt. In tempor commodo labore eu amet cillum id anim ullamco cillum non ipsum.",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
          ],
        ));
  }
}
