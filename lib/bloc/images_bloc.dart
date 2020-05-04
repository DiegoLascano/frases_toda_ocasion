// import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:frases_toda_ocasion/models/image_model.dart';
import 'package:frases_toda_ocasion/providers/images_provider.dart';
export 'package:frases_toda_ocasion/providers/images_provider.dart';

import 'package:frases_toda_ocasion/models/category_model.dart';
export 'package:frases_toda_ocasion/models/category_model.dart';

class ImagesBloc {
  final _imagesProvider = new ImagesProvider();

  final _imagesController = BehaviorSubject<List<ImageModel>>();
  final _categoriesController = BehaviorSubject<List<CategoryModel>>();
  final _downloadsController = BehaviorSubject<int>();
  final _imageIndexController = BehaviorSubject<int>();

  Stream<List<ImageModel>> get imagesStream => _imagesController.stream;
  Stream<List<CategoryModel>> get categoriesStream =>
      _categoriesController.stream;
  Stream<int> get downloadsStream => _downloadsController.stream;
  Stream<int> get imageIndexStream => _imageIndexController.stream;

  Function(int) get changedownloads => _downloadsController.sink.add;
  Function(int) get changeImageIndex => _imageIndexController.sink.add;

  List get imagesList => _imagesController.value;
  int get downloads => _downloadsController.value;
  int get imageIndex => _imageIndexController.value;

  void fetchCategories() async {
    final categories = await _imagesProvider.fetchCategories();
    _categoriesController.sink.add(categories);
  }

  void fetchImages(String category) async {
    final images = await _imagesProvider.fetchImages(category);
    _imagesController.sink.add(images);
  }

  Future<bool> updateDownloadsDB(ImageModel image, String category) async {
    final ImageModel imageFresh =
        await _imagesProvider.fetchOneImage(image.id, category);

    imageFresh.downloads += 1;

    // update image in database
    final updated = await _imagesProvider.updateImage(imageFresh, category);
    if (updated == true) changedownloads(imageFresh.downloads);

    // update images list
    fetchImages(category);

    return true;
  }

  Future<bool> downloadImage(ImageModel image) async {
    // download image to local storage
    return await _imagesProvider.downloadImage(image.imageUrl);
  }

  dispose() {
    _imagesController?.close();
    _categoriesController?.close();
    _downloadsController?.close();
    _imageIndexController?.close();
  }
}
