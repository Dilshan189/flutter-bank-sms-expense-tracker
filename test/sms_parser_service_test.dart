import 'package:flutter_test/flutter_test.dart';
import 'package:taks/core/constants/category_constants.dart';
import 'package:taks/core/services/sms_parser_service.dart';
import 'package:taks/features/transactions/data/datasources/sample_sms_data.dart';
import 'package:taks/features/transactions/domain/models/transaction_model.dart';

void main() {
  group('SmsParserService PDF Sample Messages Tests', () {
    test('Parses Sample 1: KOTTAWA INTERCHANGE (Transport/Toll)', () {
      final sms = SampleSmsData.pdfSampleMessages[0];
      final tx = SmsParserService.parseSms(sms);

      expect(tx.amount, 150.00);
      expect(tx.currency, 'LKR');
      expect(tx.type, TransactionType.expense);
      expect(tx.accountNumber, 'AC **1111');
      expect(tx.merchant, contains('KOTTAWA INTERCHANGE'));
      expect(tx.categoryId, CategoryConstants.transport.id);
      expect(tx.date.day, 28);
      expect(tx.date.month, 3);
      expect(tx.date.year, 2026);
    });

    test('Parses Sample 2: KEELLS SUPER - KOTTAWA (Groceries)', () {
      final sms = SampleSmsData.pdfSampleMessages[1];
      final tx = SmsParserService.parseSms(sms);

      expect(tx.amount, 1692.00);
      expect(tx.currency, 'LKR');
      expect(tx.type, TransactionType.expense);
      expect(tx.accountNumber, 'AC **1114');
      expect(tx.merchant, contains('KEELLS SUPER'));
      expect(tx.categoryId, CategoryConstants.groceries.id);
      expect(tx.date.day, 25);
      expect(tx.date.month, 3);
      expect(tx.date.year, 2026);
    });

    test('Parses Sample 3: P AND B FUEL MART (Fuel)', () {
      final sms = SampleSmsData.pdfSampleMessages[2];
      final tx = SmsParserService.parseSms(sms);

      expect(tx.amount, 5970.00);
      expect(tx.currency, 'LKR');
      expect(tx.type, TransactionType.expense);
      expect(tx.accountNumber, 'AC **1114');
      expect(tx.merchant, contains('FUEL MART'));
      expect(tx.categoryId, CategoryConstants.fuel.id);
      expect(tx.date.day, 25);
      expect(tx.date.month, 3);
      expect(tx.date.year, 2026);
    });
  });
}
