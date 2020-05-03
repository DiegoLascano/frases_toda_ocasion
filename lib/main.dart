import 'package:flutter/material.dart';

import 'package:frases_toda_ocasion/pages/home_page.dart';
import 'package:frases_toda_ocasion/pages/images_page.dart';
import 'package:frases_toda_ocasion/bloc/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        initialRoute: '/',
        routes: {
          '/': (BuildContext contex) => HomePage(),
          'images': (BuildContext contex) => ImagesPage(),
        },
        theme: ThemeData(
            // primaryColor: Colors.amber,
            // brightness: Brightness.light,
            // scaffoldBackgroundColor: Colors.amberAccent,
            ),
      ),
    );
  }
}
