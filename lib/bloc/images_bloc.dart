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
  final _votesController = BehaviorSubject<int>();
  final _imageIndexController = BehaviorSubject<int>();

  Stream<List<ImageModel>> get imagesStream => _imagesController.stream;
  Stream<List<CategoryModel>> get categoriesStream =>
      _categoriesController.stream;
  Stream<int> get votesStream => _votesController.stream;
  Stream<int> get imageIndexStream => _imageIndexController.stream;

  Function(int) get changeVotes => _votesController.sink.add;
  Function(int) get changeImageIndex => _imageIndexController.sink.add;

  List get imagesList => _imagesController.value;
  int get votes => _votesController.value;
  int get imageIndex => _imageIndexController.value;

  void fetchCategories() async {
    final categories = await _imagesProvider.fetchCategories();
    _categoriesController.sink.add(categories);
  }

  void fetchImages(String category) async {
    final images = await _imagesProvider.fetchImages(category);
    _imagesController.sink.add(images);
  }

  dispose() {
    _imagesController?.close();
    _categoriesController?.close();
    _votesController?.close();
    _imageIndexController?.close();
  }
}
