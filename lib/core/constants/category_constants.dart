import 'package:flutter/material.dart';

class TransactionCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const TransactionCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryConstants {
  static const TransactionCategory groceries = TransactionCategory(
    id: 'groceries',
    name: 'Groceries',
    icon: Icons.shopping_cart_rounded,
    color: Color(0xFF10B981),
  );

  static const TransactionCategory fuel = TransactionCategory(
    id: 'fuel',
    name: 'Fuel',
    icon: Icons.local_gas_station_rounded,
    color: Color(0xFFF59E0B),
  );

  static const TransactionCategory transport = TransactionCategory(
    id: 'transport',
    name: 'Transport',
    icon: Icons.directions_car_rounded,
    color: Color(0xFF3B82F6),
  );

  static const TransactionCategory foodDining = TransactionCategory(
    id: 'food_dining',
    name: 'Food & Dining',
    icon: Icons.restaurant_rounded,
    color: Color(0xFFEF4444),
  );

  static const TransactionCategory bills = TransactionCategory(
    id: 'bills',
    name: 'Bills & Utilities',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF8B5CF6),
  );

  static const TransactionCategory income = TransactionCategory(
    id: 'income',
    name: 'Income & Salary',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF059669),
  );

  static const TransactionCategory shopping = TransactionCategory(
    id: 'shopping',
    name: 'Shopping',
    icon: Icons.shopping_bag_rounded,
    color: Color(0xFFEC4899),
  );

  static const TransactionCategory other = TransactionCategory(
    id: 'other',
    name: 'Other',
    icon: Icons.category_rounded,
    color: Color(0xFF6B7280),
  );

  static List<TransactionCategory> get allCategories => [
        groceries,
        fuel,
        transport,
        foodDining,
        bills,
        income,
        shopping,
        other,
      ];

  static TransactionCategory getById(String id) {
    return allCategories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => other,
    );
  }
}
