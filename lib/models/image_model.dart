// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  String imageUrl;
  int votes;
  int downloads;
  int timestamp;

  ImageModel({
    this.imageUrl,
    this.votes,
    this.downloads,
    this.timestamp,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imageUrl: json["imageUrl"],
        votes: json["votes"],
        downloads: json["downloads"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "votes": votes,
        "downloads": downloads,
        "timestamp": timestamp,
      };
}
