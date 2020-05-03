import 'package:frases_toda_ocasion/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:frases_toda_ocasion/models/image_model.dart';

class ImagesProvider {
  final String _url = 'https://frasestodaocasion.firebaseio.com';

  Future<List<CategoryModel>> fetchCategories() async {
    final url = '$_url/categories/0.json';

    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);

    List<CategoryModel> categories = new List();
    decodedData.forEach((category, list) {
      final catTemp = new CategoryModel();
      catTemp.name = category;
      catTemp.imgUrl = list[0]['imageUrl'];
      categories.add(catTemp);
    });
    return categories;
  }

  Future<List<ImageModel>> fetchImages(String category) async {
    final url = '$_url/categories/0/$category.json';

    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    decodedData.removeAt(0);

    List<ImageModel> imagesList = new List();
    decodedData.forEach((image) {
      final imgTemp = new ImageModel.fromJson(image);
      imagesList.add(imgTemp);
    });
    return imagesList;
  }
}
