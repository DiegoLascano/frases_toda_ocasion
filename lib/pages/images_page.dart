import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:frases_toda_ocasion/bloc/provider.dart';
import 'package:frases_toda_ocasion/widgets/card_swiper.dart';

class ImagesPage extends StatefulWidget {
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ImagesBloc imagesBloc;

  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context).settings.arguments;

    imagesBloc = Provider.of(context);
    imagesBloc.fetchImages(category);

    return Scaffold(
        key: scaffoldKey,
        body: Column(
          children: <Widget>[
            _createAppbar(context, category),
            _createActions(context, imagesBloc, category),
            Expanded(
              child: _createImages(imagesBloc),
            ),
          ],
        ));
  }

  Widget _createAppbar(BuildContext context, String category) {
    return Container(
      height: 130.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.pink[500],
            Colors.pink[400],
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          _appbarBackground(),
          SafeArea(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 20.0)
                    ],
                  ),
                  Text('Frases de $category',
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  SizedBox(width: 50.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbarBackground() {
    final greenBox = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 255, 255, 0.2),
              Color.fromRGBO(255, 255, 255, 0.1),
              // Color.fromRGBO(56, 190, 201, 1.0),
              // Color.fromRGBO(190, 248, 253, 1.0),
            ])),
      ),
    );

    final blueBox = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 255, 255, 0.2),
              Color.fromRGBO(255, 255, 255, 0.1),
              // Color.fromRGBO(38, 128, 194, 1.0),
              // Color.fromRGBO(182, 224, 254, 1.0),
            ])),
      ),
    );

    final pinkBox = Transform.rotate(
      angle: -pi / 2.5,
      child: Container(
        width: 23.0,
        height: 23.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 255, 255, 0.2),
              Color.fromRGBO(255, 255, 255, 0.1),
              // Color.fromRGBO(236, 98, 188, 1.0),
              // Color.fromRGBO(241, 142, 172, 1.0)
            ])),
      ),
    );

    final yellowBox = Transform.rotate(
      angle: pi / 3.0,
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.2),
              Color.fromRGBO(255, 255, 255, 0.1),
              // Color.fromRGBO(233, 185, 73, 1.0),
              // Color.fromRGBO(248, 227, 163, 1.0),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned(top: 30.0, left: 90.0, child: greenBox),
        Positioned(top: 100.0, left: 55.0, child: pinkBox),
        Positioned(top: 110.0, left: 155.0, child: blueBox),
        Positioned(top: 40.0, right: 155.0, child: pinkBox),
        Positioned(top: 40.0, right: 40.0, child: blueBox),
        Positioned(right: 80.0, bottom: -20.0, child: yellowBox),
      ],
    );
  }

  Widget _createActions(
      BuildContext context, ImagesBloc imagesBloc, String category) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<int>(
            stream: imagesBloc.downloadsStream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final downloads = snapshot.data;

                return Row(
                  children: <Widget>[
                    Icon(
                      Icons.cloud_download,
                      color: Colors.pink,
                      size: 25.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      downloads.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Icon(
                  Icons.cloud_download,
                  color: Colors.grey,
                ));
              }
            },
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.share,
                ),
                iconSize: 25.0,
                color: Colors.pink,
                disabledColor: Colors.grey,
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.get_app,
                  color: Colors.pink,
                ),
                iconSize: 30.0,
                onPressed: () => _showAlert(context, category),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _createImages(ImagesBloc imagesBloc) {
    return StreamBuilder(
      stream: imagesBloc.imagesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final imagesList = snapshot.data;
          // load downloads of the 0-index image
          imagesBloc.changedownloads(imagesList[0].downloads);
          return Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: CardSwiper(
              images: imagesList,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _showAlert(BuildContext context, String category) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // title: Text('Descargar imagen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('La imagen se descargará en tu dispositivo'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () async {
                final imageIndex =
                    (imagesBloc.imageIndex == null) ? 0 : imagesBloc.imageIndex;
                final currentImage = imagesBloc.imagesList[imageIndex];
                final saved = await imagesBloc.downloadImage(currentImage);
                (saved)
                    ? showSnackbar(
                        'Imagen descargada correctamente', Colors.teal)
                    : showSnackbar(
                        'Error al descargar la imagen', Colors.redAccent);
                if (saved)
                  await imagesBloc.updateDownloadsDB(currentImage, category);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void showSnackbar(String message, Color color) {
    final snackbar = SnackBar(
      backgroundColor: color,
      content: Text(message),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
