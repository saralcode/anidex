import 'package:anidex/controllers/api_controllers.dart';
import 'package:anidex/pages/camera/camera_page.dart';
import 'package:anidex/pages/profile/profile_page.dart';
import 'package:anidex/pages/search/search_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Get.put(ApiControllers());
    super.initState();
  }

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
                onPressed: () async {
                  List<CameraDescription> cameras = await availableCameras();
                  Get.to(() => CameraPage(
                        cameras: cameras,
                      ));
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
        body: GetBuilder<ApiControllers>(builder: (state) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              state.todaysAnimal == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Get.to(
                            () => ProfilePage(index: state.todaysAnimalIndex));
                      },
                      child: DefaultTextStyle(
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
                                    state.todaysAnimal!.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // clipBehavior: Clip.antiAlias,
                                  // runAlignment: WrapAlignment.start,
                                  // alignment: WrapAlignment.center,
                                  // crossAxisAlignment: WrapCrossAlignment.center,
                                  // direction: Axis.vertical,
                                  // spacing: 10,
                                  children: [
                                    const Text(
                                      "Animal of the Day",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                          decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      state.todaysAnimal!.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: "serif",
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    // SizedBox(
                                    //   width: Get.size.width - 180,
                                    //   child: Text(
                                    //     state.todaysAnimal!.description,
                                    //     maxLines: 3,
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Articles",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        state.getArticles();
                      },
                      icon: const Icon(Icons.replay_outlined))
                ],
              ),
              const Divider(),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.articles.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Article article = state.articles.elementAt(index);
                    return Card(
                      child: ListTile(
                        onTap: () {
                          launchUrlString(article.url);
                        },
                        minVerticalPadding: 10,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              article.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          article.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })
            ],
          );
        }));
  }
}
