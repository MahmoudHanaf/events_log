import 'package:charging_station/models/model.dart';

class BannerModel {
  final String link;
  final ImageModel image;

  BannerModel({required this.link, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      link: json['url'] ?? "",
      image: ImageModel.fromJson(json['image']),
    );
  }
}
