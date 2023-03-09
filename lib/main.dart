import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoo_finances/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yahoo finances',
      initialRoute: Routes.getHomeRoute(),
      getPages: Routes.routes,
    );
  }
}
