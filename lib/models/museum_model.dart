import 'package:digium/models/gallery_model.dart';

class MuseumModel {
  late int id;
  late int price;
  late String name;
  late String background;
  late String panorama;
  late String description;
  late String address;
  late String phone;
  late DateTime yearBuilt;
  late double latitude;
  late double longitude;
  late List<GalleryModel>? galleries;

  MuseumModel({
    required this.id,
    required this.name,
    required this.background,
    required this.panorama,
    required this.description,
    required this.address,
    required this.phone,
    required this.yearBuilt,
    required this.latitude,
    required this.longitude,
    required this.price,
    this.galleries,
  });

  MuseumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    background = json['background'];
    panorama = json['panorama'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    yearBuilt = DateTime.parse(json['year_built']);
    latitude = json['latitude'];
    longitude = json['longitude'];
    price = json['price'];

    // parse array of object
    if (json['galleries'] != null) {
      galleries = json['galleries']
          .map((gallery) => GalleryModel.fromJson(gallery))
          .toList();
    }
  }
}
