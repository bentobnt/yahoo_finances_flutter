import 'package:intl/intl.dart';

class Helper {
  static String getFormattedValue(double openValue) {
    if (openValue == 0) {
      return 'R\$ 0,00';
    }

    final NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(openValue);
  }
}