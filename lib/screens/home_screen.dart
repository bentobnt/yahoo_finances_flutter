import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:yahoo_finances/controllers/home_controller.dart';
import 'package:yahoo_finances/routes/routes.dart';
import 'package:yahoo_finances/widgets/active_table.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Color(0xFFB281248),
      ),
      body: _getContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.getChartRoute(),
            arguments: controller.activeData,
          );
        },
        tooltip: 'Chart',
        child: const Icon(Icons.bar_chart),
      ),
    );
  }

  Widget _getContent() {
    final today = DateTime.now();
    var monthAgo = DateTime(today.year, today.month - 1, today.day);
    controller.fetchData('AAPL', monthAgo, today);

    return Obx(
      () {
        return SingleChildScrollView(
          child: ActiveTable(
            data: controller.activeData,
            tableTitle: "Apple Inc. (APPL)",
          ),
        );
      },
    );
  }
}
