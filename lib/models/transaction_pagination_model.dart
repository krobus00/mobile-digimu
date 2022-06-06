import 'package:digium/models/pagination_model.dart';
import 'package:digium/models/transaction_model.dart';

class TransactionPaginationModel {
  TransactionPaginationModel({
    required this.data,
    required this.paging,
  });

  List<TransactionModel> data;
  PaginationModel paging;

  factory TransactionPaginationModel.fromJson(Map<String, dynamic> json) =>
      TransactionPaginationModel(
        data: List<TransactionModel>.from(
          json["data"].map(
            (x) => TransactionModel.fromJson(x),
          ),
        ),
        paging: PaginationModel.fromJson(json["paging"]),
      );
}
