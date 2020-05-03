// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String imgUrl;
  String name;

  CategoryModel({
    this.imgUrl,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        imgUrl: json["imgUrl"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "imgUrl": imgUrl,
        "name": name,
      };
}
