import 'package:get/get.dart';
import 'package:yahoo_finances/models/stock_chart.dart';

class HomeController extends GetxController {
  HomeController();

  final RxList<ActiveData> _activeData = <ActiveData>[].obs;
  List<ActiveData> get activeData => _activeData.toList();
  set activeData(value) => _activeData.value = value;

  final _connect = GetConnect();

  Future<dynamic> fetchData(String active, DateTime startDate, DateTime endDate,
      {String stringInteval = '1d'}) async {
    var stringStartDate = startDate.millisecondsSinceEpoch.toString();
    if (stringStartDate.isNotEmpty) {
      stringStartDate =
          stringStartDate.substring(0, stringStartDate.length - 3);
    }
    var stringEndDate = endDate.millisecondsSinceEpoch.toString();
    if (stringEndDate.isNotEmpty) {
      stringEndDate = stringEndDate.substring(0, stringEndDate.length - 3);
    }
    final query =
        '?symbols=$active&symbol=$active&period1=$stringStartDate&period2=$stringEndDate&interval=$stringInteval&includePrePost=true&cachecounter=1';
    final response = await _connect
        .get('https://query2.finance.yahoo.com/v8/finance/chart/$active$query');

    await _setupObjectsWithResponse(response.body);
  }

  _setupObjectsWithResponse(dynamic response) async {
    _activeData.value = [];
    StockChart stockChart = StockChart.fromJson(response);
    final openValues =
        stockChart.chart?.result?.first.indicators?.quote?.first.open ?? [];
    final timeStampValues = stockChart.chart?.result?.first.timestamp ?? [];

    if (openValues.length == timeStampValues.length) {
      timeStampValues.asMap().forEach((index, value) {
        var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
        ActiveData activeData =
            ActiveData(date: date, openValue: openValues[index]);
        _activeData.add(activeData);
      });
    }
  }
}
