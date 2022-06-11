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
    required this.museum,
  });

  int id;
  int userId;
  int museumId;
  int totalPrice;
  int qty;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  TransactionMuseumModel museum;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        userId: json["user_id"],
        museumId: json["museum_id"],
        totalPrice: json["total_price"],
        qty: json["qty"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        museum: TransactionMuseumModel.fromJson(json["museum"]),
      );
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
