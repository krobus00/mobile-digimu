class TransactionModel {
  TransactionModel({
    required this.id,
    required this.userId,
    required this.museumId,
    required this.totalPrice,
    required this.qty,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.museum,
    this.items,
  });

  late int id;
  late int userId;
  late int museumId;
  late int totalPrice;
  late int qty;
  late String status;
  late DateTime createdAt;
  late DateTime updatedAt;
  TransactionMuseumModel? museum;
  late List<TransactionItemModel>? items;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    museumId = json["museum_id"];
    totalPrice = json["total_price"];
    qty = json["qty"];
    status = json["status"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    if (json["museum"] != null) {
      museum = TransactionMuseumModel.fromJson(json["museum"]);
    }

    if (json['transaction_item'] != null) {
      items = (json['transaction_item'] as List)
          .map((item) => TransactionItemModel.fromJson(item))
          .toList();
    }
  }
}

class TransactionMuseumModel {
  TransactionMuseumModel({
    required this.id,
    required this.name,
    required this.background,
    required this.price,
  });

  int id;
  String name;
  String background;
  int price;

  factory TransactionMuseumModel.fromJson(Map<String, dynamic> json) =>
      TransactionMuseumModel(
        id: json["id"],
        name: json["name"],
        background: json["background"],
        price: json["price"],
      );
}

class TransactionItemModel {
  TransactionItemModel({
    required this.id,
    required this.transactionId,
    required this.name,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int transactionId;
  String name;
  dynamic qrCode;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) =>
      TransactionItemModel(
        id: json["id"],
        transactionId: json["transaction_id"],
        name: json["name"],
        qrCode: json["qr_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
