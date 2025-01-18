import 'package:anidex/controllers/api_controllers.dart';
import 'package:anidex/customs/inputDecoration/input_decoration.dart';
import 'package:anidex/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  final String? filter;
  const SearchPage({super.key, this.filter});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController search = TextEditingController();
  @override
  void initState() {
    ApiControllers c = Get.find<ApiControllers>();
    if (widget.filter != null) {
      search.text = widget.filter!;
      setState(() {});
    }
    c.getAnimals(filter: widget.filter);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiControllers>(builder: (state) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leadingWidth: 40,
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: search,
                decoration: inputDecoration(
                    hintText: "Search",
                    isRequired: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          state.getAnimals(filter: search.text);
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.pink,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          body: state.animals.isEmpty
              ? const Center(
                  child: Text(
                    "No Data Available",
                    textScaleFactor: 1.2,
                  ),
                )
              : GridView.builder(
                  itemCount: state.animals.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    Animal animal = state.animals.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Get.to(() => ProfilePage(
                              index: index,
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.purple.withOpacity(0.8),
                            title: Text(animal.name),
                            subtitle: Text(animal.type),
                          ),
                          child: Image.network(
                            state.getImageUrl(animal.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }));
    });
  }
}
