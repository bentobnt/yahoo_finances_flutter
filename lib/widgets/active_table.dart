import 'package:flutter/material.dart';
import 'package:yahoo_finances/helpers/helper.dart';
import 'package:yahoo_finances/models/stock_chart.dart';
import 'package:intl/intl.dart';

class ActiveTable extends StatelessWidget {
  final List<ActiveData> data;
  final String tableTitle;

  const ActiveTable({Key? key, required this.data, this.tableTitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ..._getTable(),
        ],
      ),
    );
  }

  List<Widget> _getTable() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 32,
        ),
        child: Visibility(
          visible: tableTitle != '',
          child: Text(
            tableTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 80,
        ),
        child: Table(
          border: const TableBorder(
            bottom: BorderSide(color: Colors.grey),
            horizontalInside: BorderSide(color: Colors.grey),
            top: BorderSide(color: Colors.grey),
          ),
          children: [
            const TableRow(
              children: [
                Text(
                  'Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Valor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Variação \nD -1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Variação primeira data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ..._getTableRows(),
          ],
        ),
      ),
    ];
  }

  List<TableRow> _getTableRows() {
    final List<TableRow> rows = [];

    for (var stockChart in data) {
      final variationD1Text = _getVariationD1(stockChart);
      final variationFirstDateText = _getVariationFirstDate(stockChart);
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                _getFormattedDate(stockChart.date),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                Helper.getFormattedValue(stockChart.openValue),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                variationD1Text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      variationD1Text.contains('-') ? Colors.red : Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                variationFirstDateText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: variationFirstDateText.contains('-')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  String _getFormattedDate(DateTime date) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  String _getVariationD1(ActiveData stockChart) {
    var index = data.indexOf(stockChart);
    var percentageDifference = '-';
    if (index > 0) {
      final d1StockChart = data[index - 1];

      percentageDifference = ((stockChart.openValue - d1StockChart.openValue) *
              100 /
              d1StockChart.openValue)
          .toStringAsFixed(2);
    }

    return index == 0 ? '-' : percentageDifference + '%';
  }

  String _getVariationFirstDate(ActiveData stockChart) {
    var index = data.indexOf(stockChart);
    var firstStockChart = data.first;

    var percentageDifference =
        ((stockChart.openValue - firstStockChart.openValue) *
                100 /
                firstStockChart.openValue)
            .toStringAsFixed(2);

    return index == 0 ? '-' : percentageDifference + '%';
  }
}
