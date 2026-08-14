import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/sms_parser_service.dart';
import '../../data/datasources/sample_sms_data.dart';
import '../../domain/models/transaction_model.dart';
import 'filter_provider.dart';

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionNotifier() : super([]) {
    _loadSampleTransactions();
  }

  void _loadSampleTransactions() {
    final transactions = SampleSmsData.allSampleMessages
        .map((sms) => SmsParserService.parseSms(sms))
        .toList();
    state = transactions;
  }

  void addTransactionFromSms(String rawSms) {
    if (rawSms.trim().isEmpty) return;
    final newTransaction = SmsParserService.parseSms(rawSms);
    state = [newTransaction, ...state];
  }

  void updateCategory(String transactionId, String newCategoryId) {
    state = state.map((tx) {
      if (tx.id == transactionId) {
        return tx.copyWith(
          categoryId: newCategoryId,
          isCategoryManuallySet: true,
        );
      }
      return tx;
    }).toList();
  }

  void deleteTransaction(String transactionId) {
    state = state.where((tx) => tx.id != transactionId).toList();
  }

  void resetToDefaults() {
    _loadSampleTransactions();
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<TransactionModel>>((ref) {
  return TransactionNotifier();
});

final filteredTransactionsProvider = Provider<List<TransactionModel>>((ref) {
  final transactions = ref.watch(transactionProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final categoryFilter = ref.watch(selectedCategoryFilterProvider);
  final typeFilter = ref.watch(typeFilterProvider);

  return transactions.where((tx) {
    // Search query filter
    final matchesSearch = searchQuery.isEmpty ||
        tx.merchant.toLowerCase().contains(searchQuery) ||
        tx.rawSms.toLowerCase().contains(searchQuery) ||
        tx.amount.toString().contains(searchQuery);

    // Category filter
    final matchesCategory =
        categoryFilter == null || tx.categoryId == categoryFilter;

    // Type filter
    final matchesType = typeFilter == null || tx.type == typeFilter;

    return matchesSearch && matchesCategory && matchesType;
  }).toList();
});

final totalIncomeProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionProvider);
  return transactions
      .where((tx) => tx.type == TransactionType.income)
      .fold(0.0, (sum, tx) => sum + tx.amount);
});

final totalExpenseProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionProvider);
  return transactions
      .where((tx) => tx.type == TransactionType.expense)
      .fold(0.0, (sum, tx) => sum + tx.amount);
});

final netBalanceProvider = Provider<double>((ref) {
  final income = ref.watch(totalIncomeProvider);
  final expense = ref.watch(totalExpenseProvider);
  return income - expense;
});
