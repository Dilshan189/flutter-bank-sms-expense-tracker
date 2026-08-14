import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/transaction_model.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoryFilterProvider = StateProvider<String?>((ref) => null);

final typeFilterProvider = StateProvider<TransactionType?>((ref) => null);
