enum TransactionType { expense, income }

class TransactionModel {
  final String id;
  final String rawSms;
  final String sender;
  final double amount;
  final String currency;
  final TransactionType type;
  final String merchant;
  final String accountNumber;
  final DateTime date;
  final String categoryId;
  final bool isCategoryManuallySet;

  const TransactionModel({
    required this.id,
    required this.rawSms,
    this.sender = 'BANK_SMS',
    required this.amount,
    this.currency = 'LKR',
    required this.type,
    required this.merchant,
    required this.accountNumber,
    required this.date,
    required this.categoryId,
    this.isCategoryManuallySet = false,
  });

  TransactionModel copyWith({
    String? id,
    String? rawSms,
    String? sender,
    double? amount,
    String? currency,
    TransactionType? type,
    String? merchant,
    String? accountNumber,
    DateTime? date,
    String? categoryId,
    bool? isCategoryManuallySet,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      rawSms: rawSms ?? this.rawSms,
      sender: sender ?? this.sender,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      merchant: merchant ?? this.merchant,
      accountNumber: accountNumber ?? this.accountNumber,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      isCategoryManuallySet:
          isCategoryManuallySet ?? this.isCategoryManuallySet,
    );
  }
}
