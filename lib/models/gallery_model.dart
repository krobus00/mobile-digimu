class GalleryModel {
  int id;
  String photo;

  GalleryModel({
    required this.id,
    required this.photo,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        id: json["id"],
        photo: json["photo"],
      );
}
