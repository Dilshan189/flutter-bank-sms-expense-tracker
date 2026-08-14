import '../constants/category_constants.dart';
import '../../features/transactions/domain/models/transaction_model.dart';

class CategorizerService {
  static String categorize({
    required String merchant,
    required String rawSms,
    required TransactionType type,
  }) {
    if (type == TransactionType.income) {
      return CategoryConstants.income.id;
    }

    final text = '${merchant.toLowerCase()} ${rawSms.toLowerCase()}';

    // Groceries
    if (text.contains('keells') ||
        text.contains('cargills') ||
        text.contains('arpico') ||
        text.contains('supermarket') ||
        text.contains('super') ||
        text.contains('spar') ||
        text.contains('grocer')) {
      return CategoryConstants.groceries.id;
    }

    // Fuel
    if (text.contains('fuel') ||
        text.contains('petrol') ||
        text.contains('ioc') ||
        text.contains('laugfs') ||
        text.contains('filling') ||
        text.contains('shed')) {
      return CategoryConstants.fuel.id;
    }

    // Transport
    if (text.contains('interchange') ||
        text.contains('expressway') ||
        text.contains('highway') ||
        text.contains('pickme') ||
        text.contains('uber') ||
        text.contains('toll') ||
        text.contains('transport') ||
        text.contains('taxi')) {
      return CategoryConstants.transport.id;
    }

    // Food & Dining
    if (text.contains('restaurant') ||
        text.contains('cafe') ||
        text.contains('pizza') ||
        text.contains('kfc') ||
        text.contains('mcdonald') ||
        text.contains('bakery') ||
        text.contains('food') ||
        text.contains('dining')) {
      return CategoryConstants.foodDining.id;
    }

    // Bills & Utilities
    if (text.contains('ceb') ||
        text.contains('water') ||
        text.contains('dialog') ||
        text.contains('mobitel') ||
        text.contains('slt') ||
        text.contains('utility') ||
        text.contains('electricity') ||
        text.contains('bill')) {
      return CategoryConstants.bills.id;
    }

    // Shopping
    if (text.contains('fashion') ||
        text.contains('store') ||
        text.contains('clothing') ||
        text.contains('mall') ||
        text.contains('daraz') ||
        text.contains('amazon')) {
      return CategoryConstants.shopping.id;
    }

    return CategoryConstants.other.id;
  }
}
