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
  String description;
  String content;
  String type;
  String image;
  int itsDay;
  Animal.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        content = json['content'],
        image = json['image'],
        type = json['type'],
        itsDay = json['itsDay'];

  Animal(
      {required this.name,
      required this.description,
      required this.content,
      required this.type,
      required this.itsDay,
      required this.image});
}

class ApiControllers extends GetxController {
  String apiURL = "http://10.0.2.2:8000";
  List<Article> articles = [];
  List<Animal> animals = [];
  Animal? todaysAnimal;

  Future<void> getArticles() async {
    articles.clear();
    update();
    Uri uri = Uri.parse("$apiURL/articles/v1/articles/?format=json");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        for (var element in data) {
          articles.add(Article.fromJson(element));
        }
      }
      update();
    } catch (e) {
      log("Error occured while fetching.. ", error: e);
    }
  }

  Future<void> getAnimals() async {
    animals.clear();
    update();
    Uri uri = Uri.parse("$apiURL/animals/v1/animals/?format=json");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        for (var element in data) {
          animals.add(Animal.fromJson(element));
        }
      }
      todaysAnimal =
          animals.firstWhere((element) => element.itsDay == DateTime.now().day);
      update();
    } catch (e) {
      log("Error occured while fetching.. ", error: e);
    }
  }

  @override
  void onInit() {
    getArticles();
    getAnimals();
    super.onInit();
  }
}
