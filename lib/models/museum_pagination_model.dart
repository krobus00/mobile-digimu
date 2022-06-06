import 'package:digium/models/museum_model.dart';
import 'package:digium/models/pagination_model.dart';

class MuseumPaginationModel {
  MuseumPaginationModel({
    required this.data,
    required this.paging,
  });

  List<MuseumModel> data;
  PaginationModel paging;

  factory MuseumPaginationModel.fromJson(Map<String, dynamic> json) =>
      MuseumPaginationModel(
        data: List<MuseumModel>.from(
          json["data"].map(
            (x) => MuseumModel.fromJson(x),
          ),
        ),
        paging: PaginationModel.fromJson(json["paging"]),
      );
}
