import 'package:digium/models/museum_model.dart';

class MuseumPaginationModel {
  MuseumPaginationModel({
    required this.currentPage,
    required this.itemsPerPage,
    required this.count,
    required this.totalPage,
    required this.items,
  });

  int currentPage;
  int itemsPerPage;
  int count;
  int totalPage;
  List<MuseumModel> items;

  factory MuseumPaginationModel.fromJson(Map<String, dynamic> json) =>
      MuseumPaginationModel(
        currentPage: json["currentPage"],
        itemsPerPage: json["itemsPerPage"],
        count: json["count"],
        totalPage: json["totalPage"],
        items: List<MuseumModel>.from(
          json["items"].map(
            (x) => MuseumModel.fromJson(x),
          ),
        ),
      );
}
