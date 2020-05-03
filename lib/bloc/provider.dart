import 'package:flutter/material.dart';

import 'package:frases_toda_ocasion/bloc/images_bloc.dart';
export 'package:frases_toda_ocasion/bloc/images_bloc.dart';

class Provider extends InheritedWidget {
  final _imagesBloc = new ImagesBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ImagesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._imagesBloc;
  }
}
