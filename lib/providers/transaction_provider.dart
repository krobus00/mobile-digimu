import 'package:digium/models/transaction_model.dart';
import 'package:digium/models/transaction_pagination_model.dart';
import 'package:digium/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  final _transactionService = TransactionService();
  List<TransactionModel> _transactions = [];
  bool _paginationHasNext = true;

  List<TransactionModel> get transactions => _transactions;

  set transactions(List<TransactionModel> museums) {
    _transactions = museums;
    notifyListeners();
  }

  Future<bool> getTransactions({
    required bool firstFetch,
    int? page,
    int? paginate,
  }) async {
    try {
      if (!_paginationHasNext && !firstFetch) {
        return false;
      }
      TransactionPaginationModel transactions =
          await _transactionService.getTransactions(
        page: page,
        paginate: paginate,
      );

      if (firstFetch) {
        _transactions = transactions.data;
      } else {
        _transactions.addAll(transactions.data);
      }
      _paginationHasNext = transactions.paging.lastPage >= (page ?? 1);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
