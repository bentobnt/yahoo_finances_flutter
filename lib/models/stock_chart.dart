class StockChart {
  Chart? chart;

  StockChart({this.chart});

  StockChart.fromJson(Map<String, dynamic> json) {
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chart != null) {
      data['chart'] = this.chart!.toJson();
    }
    return data;
  }
}

class Chart {
  List<Result>? result;
  Null? error;

  Chart({this.result, this.error});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Result {
  List<int>? timestamp;
  Indicators? indicators;

  Result({this.timestamp, this.indicators});

  Result.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'].cast<int>();
    indicators = json['indicators'] != null
        ? new Indicators.fromJson(json['indicators'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    if (this.indicators != null) {
      data['indicators'] = this.indicators!.toJson();
    }
    return data;
  }
}

class Indicators {
  List<Quote>? quote;

  Indicators({this.quote});

  Indicators.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = <Quote>[];
      json['quote'].forEach((v) {
        quote!.add(new Quote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  List<double>? open;
  Quote({
    this.open,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    open = json['open'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    return data;
  }
}

class ActiveData {
  final double openValue;
  final DateTime date;

  ActiveData({required this.date, required this.openValue});

  factory ActiveData.fromJson(dynamic json) {
    double openValueDouble = double.parse(json['open']);
    final splitted = json['date'].split('/');
    final year = int.parse(splitted[2]);
    final month = int.parse(splitted[1]);
    final day = int.parse(splitted[0]);
    DateTime dateFormatted = DateTime(year, month, day);
    return ActiveData(date: dateFormatted, openValue: openValueDouble);
  }
}
