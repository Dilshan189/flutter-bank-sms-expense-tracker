import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount, {String currency = 'LKR'}) {
    final formatter = NumberFormat.currency(
      symbol: '$currency ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }
}
