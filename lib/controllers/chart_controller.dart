import 'package:get/get.dart';
import 'package:yahoo_finances/helpers/helper.dart';
import 'package:yahoo_finances/models/stock_chart.dart';

class ChartController extends GetxController {
  ChartController();

  final List<ActiveData>? data = null;

  final RxList<ActiveData> _activeData = <ActiveData>[].obs;
  List<ActiveData> get activeData => _activeData.toList();
  set activeData(value) => _activeData.value = value;

  String getActiveTitleAndVariation() {
    String percenteValue = '';
    percenteValue = ((activeData.last.openValue - activeData.first.openValue) *
            100 /
            activeData.first.openValue)
        .toStringAsFixed(2);
    return 'APPL ($percenteValue%)';
  }
}
