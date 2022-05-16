class GalleryModel {
  late int id;
  late String photo;

  GalleryModel({
    required this.id,
    required this.photo,
  });

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
  }
}
