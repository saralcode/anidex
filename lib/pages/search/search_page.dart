import 'package:anidex/customs/inputDecoration/input_decoration.dart';
import 'package:anidex/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      child: const Icon(
                        Icons.search,
                        color: Colors.pink,
                      ),
                    ),
                  )),
            ),
          ),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() => const ProfilePage());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.purple.withOpacity(0.8),
                      title: const Text("Cat"),
                      subtitle: const Text("Pet"),
                    ),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }));
  }
}
