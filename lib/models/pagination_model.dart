class PaginationModel {
  PaginationModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
  });

  int currentPage;
  int from;
  int lastPage;
  int perPage;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
      );
}
