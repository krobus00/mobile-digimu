import 'package:digium/models/transaction_model.dart';
import 'package:digium/models/transaction_pagination_model.dart';
import 'package:digium/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TransactionProvider with ChangeNotifier {
  final _transactionService = TransactionService();
  late int _transactionId;
  List<TransactionModel> _transactions = [];
  late TransactionModel _transactionItems;
  bool _paginationHasNext = true;

  List<TransactionModel> get transactions => _transactions;

  TransactionModel get transactionItems => _transactionItems;

  set transactions(List<TransactionModel> transaction) {
    _transactions = transaction;
    notifyListeners();
  }

  set transactionItems(TransactionModel transactionItems) {
    _transactionItems = transactionItems;
    notifyListeners();
  }

  Future<bool> getTransactions({
    required bool firstFetch,
    int? page,
    int? paginate,
  }) async {
    try {
      if (firstFetch) {
        _paginationHasNext = true;
      }
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

  Future<bool> getTransactionItems({required int transactionId}) async {
    try {
      TransactionModel transactions = await _transactionService
          .getTransactionItems(transactionId: transactionId);
      _transactionItems = transactions;

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> uploadReceipt({
    required int transactionId,
    required XFile file,
  }) async {
    try {
      await _transactionService.uploadReceipt(
        transactionId: transactionId,
        file: file,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
