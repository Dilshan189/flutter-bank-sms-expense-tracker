import 'categorizer_service.dart';
import '../../features/transactions/domain/models/transaction_model.dart';

class SmsParserService {
  static TransactionModel parseSms(String rawSms, {String sender = 'BANK_SMS'}) {
    final String cleanSms = rawSms.trim();

    // 1. Amount & Currency
    final amountResult = _extractAmount(cleanSms);
    final double amount = amountResult.amount;
    final String currency = amountResult.currency;

    // 2. Transaction Type
    final TransactionType type = _extractType(cleanSms);

    // 3. Account Number
    final String accountNumber = _extractAccount(cleanSms);

    // 4. Merchant / Location
    final String merchant = _extractMerchant(cleanSms);

    // 5. Date & Time
    final DateTime date = _extractDateTime(cleanSms);

    // 6. Category
    final String categoryId = CategorizerService.categorize(
      merchant: merchant,
      rawSms: cleanSms,
      type: type,
    );

    return TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      rawSms: cleanSms,
      sender: sender,
      amount: amount,
      currency: currency,
      type: type,
      merchant: merchant,
      accountNumber: accountNumber,
      date: date,
      categoryId: categoryId,
    );
  }

  static ({double amount, String currency}) _extractAmount(String sms) {
    // Regex for LKR 1,692.00, Rs. 150.00, LKR 150, USD 20.00, etc.
    final RegExp amountRegex = RegExp(
      r'(LKR|Rs\.?|USD|\$)\s*([\d,]+(?:\.\d{1,2})?)',
      caseSensitive: false,
    );

    final match = amountRegex.firstMatch(sms);
    if (match != null) {
      final currencyStr = match.group(1) ?? 'LKR';
      final amountStr = match.group(2)?.replaceAll(',', '') ?? '0';
      final double parsedAmount = double.tryParse(amountStr) ?? 0.0;
      return (
        amount: parsedAmount,
        currency: currencyStr.toUpperCase().replaceAll('.', ''),
      );
    }

    // Fallback: search for stand-alone numbers like 150.00
    final RegExp numericRegex = RegExp(r'([\d,]+\.\d{2})');
    final numMatch = numericRegex.firstMatch(sms);
    if (numMatch != null) {
      final val = numMatch.group(1)?.replaceAll(',', '') ?? '0';
      return (amount: double.tryParse(val) ?? 0.0, currency: 'LKR');
    }

    return (amount: 0.0, currency: 'LKR');
  }

  static TransactionType _extractType(String sms) {
    final lower = sms.toLowerCase();
    if (lower.contains('credited') ||
        lower.contains('received') ||
        lower.contains('deposited') ||
        lower.contains('added')) {
      return TransactionType.income;
    }
    return TransactionType.expense;
  }

  static String _extractAccount(String sms) {
    // Match patterns like AC **1111, A/C **1114, Account 1234, Card **5678
    final RegExp accRegex = RegExp(
      r'(AC|A/C|Account|Card)\s*([\*\d]+)',
      caseSensitive: false,
    );
    final match = accRegex.firstMatch(sms);
    if (match != null) {
      return '${match.group(1)} ${match.group(2)}';
    }
    return 'AC **Primary';
  }

  static String _extractMerchant(String sms) {
    // Pattern 1: POS at <MERCHANT> <TERMINAL_ID> <DATE>
    // e.g. "via POS at KOTTAWA INTERCHANGE 10500302 28/03/2026"
    final RegExp posRegex = RegExp(
      r'at\s+([A-Za-z0-9\s\-\&]+?)(?=\s+\d{6,10}|\s+\d{2}\/\d{2}|\s+To\s+Inq|\s*$)',
      caseSensitive: false,
    );

    final match = posRegex.firstMatch(sms);
    if (match != null) {
      String merchant = match.group(1)?.trim() ?? '';
      // Remove unwanted leading/trailing words if any
      if (merchant.isNotEmpty) {
        return merchant;
      }
    }

    // Pattern 2: "at <Merchant>"
    final RegExp genericAtRegex = RegExp(r'at\s+([A-Za-z0-9\s\-]+)', caseSensitive: false);
    final matchAt = genericAtRegex.firstMatch(sms);
    if (matchAt != null) {
      return matchAt.group(1)?.trim() ?? 'Unknown Merchant';
    }

    return 'General Merchant';
  }

  static DateTime _extractDateTime(String sms) {
    // Regex for dd/MM/yyyy HH:mm:ss or dd/MM/yyyy
    final RegExp dateRegex = RegExp(
      r'(\d{2}\/\d{2}\/\d{4})\s*(\d{2}:\d{2}:\d{2})?',
    );

    final match = dateRegex.firstMatch(sms);
    if (match != null) {
      final datePart = match.group(1);
      final timePart = match.group(2) ?? '00:00:00';

      try {
        final parts = datePart!.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        final timeParts = timePart.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final second = int.parse(timeParts[2]);

        return DateTime(year, month, day, hour, minute, second);
      } catch (_) {
        return DateTime.now();
      }
    }

    return DateTime.now();
  }
}
