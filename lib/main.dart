import 'package:anidex/pages/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anidex",
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey.withOpacity(0.6),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0)),
      home: const HomePage(),
    );
  }
}
