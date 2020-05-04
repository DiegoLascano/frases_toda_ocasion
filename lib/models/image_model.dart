// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  String id;
  int downloads;
  String imageUrl;

  ImageModel({
    this.id,
    this.downloads,
    this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        downloads: json["downloads"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "downloads": downloads,
        "imageUrl": imageUrl,
      };
}
