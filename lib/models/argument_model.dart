import 'package:digium/models/museum_model.dart';
import 'package:digium/models/transaction_model.dart';

class TransactionDetailArgument {
  final TransactionModel transaction;

  TransactionDetailArgument({required this.transaction});
}

class TransactionMuseum {
  final MuseumModel museum;

  TransactionMuseum({required this.museum});
  
}

class TicketDetailArgument {
  final TransactionItemModel item;

  TicketDetailArgument({required this.item});
}
