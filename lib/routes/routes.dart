import 'package:get/route_manager.dart';
import 'package:yahoo_finances/bindings/bindings.dart';
import 'package:yahoo_finances/main.dart';
import 'package:yahoo_finances/screens/chart_screen.dart';
import 'package:yahoo_finances/screens/home_screen.dart';

class Routes {
  static String home = "/";
  static String chart = "/chart";

  static String getHomeRoute() {
    return home;
  }

  static String getChartRoute() {
    return chart;
  }

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () {
        return const HomeScreen();
      },
      binding: BaseBinding(),
    ),
    GetPage(
      name: chart,
      page: () {
        return ChartScreen();
      },
      binding: BaseBinding(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
