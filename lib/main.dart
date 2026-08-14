import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/transactions/presentation/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BankSmsTrackerApp(),
    ),
  );
}

class BankSmsTrackerApp extends StatelessWidget {
  const BankSmsTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank SMS Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
