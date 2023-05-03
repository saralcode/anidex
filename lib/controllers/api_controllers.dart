import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Article {
  String title;
  String description;
  String url;
  String image;
  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        url = json['url'],
        image = json['image'];

  Article(
      {required this.title,
      required this.description,
      required this.url,
      required this.image});
}

class Animal {
  String name;
  int id;
  String description;
  String content;
  String type;
  String image;
  int itsDay;
  Animal.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        description = json['description'],
        content = json['content'],
        image = json['image'],
        type = json['type'],
        itsDay = json['itsDay'];

  Animal(
      {required this.name,
      required this.description,
      required this.content,
      required this.id,
      required this.type,
      required this.itsDay,
      required this.image});
}

class ApiControllers extends GetxController {
  String apiURL = "http://192.168.159.172:8000";
  RxList articles = [].obs;
  RxList animals = [].obs;
  Animal? todaysAnimal;

  Future<void> getArticles() async {
    articles.clear();
    // update();
    // notifyChildrens();
    Uri uri = Uri.parse("$apiURL/articles/v1/articles/?format=json");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        log("$data");
        for (int i = 0; i < data.length; i++) {
          articles.add(Article.fromJson(data[i]));
        }
      }
      // update();
    } catch (e) {
      log(
        "Error occured while fetching.. $e ",
      );
    }
  }

  Future<void> getAnimals({String? filter}) async {
    animals.clear();

    Uri uri = Uri.parse("$apiURL/animals/v1/animals/?format=json");
    if (filter != null) {
      uri = Uri.parse("$apiURL/animals/v1/animals/?search=$filter&format=json");
    }
    log(uri.toString());
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        log("$data");
        for (int i = 0; i < data.length; i++) {
          animals.add(Animal.fromJson(data[i]));
        }
      }
      update();
      try {
        todaysAnimal = animals
            .firstWhere((element) => element.itsDay == DateTime.now().day);
      } catch (e) {
        log("Eerr");
      }
    } catch (e) {
      log("Error occured while fetching.. $e");
    }
  }

  @override
  void onInit() {
    getArticles();
    getAnimals();
    super.onInit();
  }
}
