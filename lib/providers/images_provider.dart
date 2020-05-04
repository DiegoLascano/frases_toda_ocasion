import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:frases_toda_ocasion/models/category_model.dart';
import 'package:frases_toda_ocasion/models/image_model.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

class ImagesProvider {
  final String _url = 'https://frasestodaocasion.firebaseio.com';

  Future<List<CategoryModel>> fetchCategories() async {
    final url = '$_url/categories/0.json';

    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    if (decodedData == null) return null;

    List<CategoryModel> categories = new List();
    decodedData.forEach((category, list) {
      final catTemp = new CategoryModel();
      catTemp.name = category;
      catTemp.imageUrl = list[0]['imageUrl'];
      categories.add(catTemp);
    });
    return categories;
  }

  Future<List<ImageModel>> fetchImages(String category) async {
    final url = '$_url/categories/0/$category.json';

    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    if (decodedData == null) return null;
    decodedData.removeAt(0);

    List<ImageModel> imagesList = new List();
    for (var i = 0; i < decodedData.length; i++) {
      final imageTemp = new ImageModel.fromJson(decodedData[i]);
      imageTemp.id = (i + 1).toString();
      imagesList.add(imageTemp);
    }
    return imagesList;
  }

  Future<ImageModel> fetchOneImage(String id, String category) async {
    final url = '$_url/categories/0/$category/$id.json';

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final image = new ImageModel.fromJson(decodedData);
    image.id = id;

    return image;
  }

  Future<bool> updateImage(ImageModel image, String category) async {
    final url = '$_url/categories/0/$category/${image.id}.json';

    final response = await http.put(url, body: imageModelToJson(image));
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Error');
      return false;
    }
    return true;
  }

  Future<bool> downloadImage(String imageUrl) async {
    final response = await http.get(imageUrl);
    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    return (filePath == null) ? false : true;
  }
}
