class BannerModel {
  late int id;
  late String name;
  late String image;
  late String link;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  BannerModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.link,
      this.createdAt,
      this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    link = json['link'];
    print("${json['id']}, ${json['name']}, ${json['image']}, ${json['link']}");

    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }

    if (json['updated_at'] != null) {
      updatedAt = DateTime.parse(json['updated_at']);
    }
  }
}
