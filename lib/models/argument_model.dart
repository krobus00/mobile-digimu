import 'package:digium/models/transaction_model.dart';

class TransactionDetailArgument {
  final TransactionModel transaction;

  TransactionDetailArgument({required this.transaction});
}

class TicketDetailArgument {
  final TransactionItemModel item;

  TicketDetailArgument({required this.item});
}
