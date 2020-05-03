import 'package:flutter/material.dart';

import 'package:frases_toda_ocasion/bloc/provider.dart';
import 'package:frases_toda_ocasion/models/category_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imagesBloc = Provider.of(context);
    imagesBloc.fetchCategories();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _createHeader(),
              Expanded(
                child: _createCategories(imagesBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCategories(ImagesBloc imagesBloc) {
    return StreamBuilder(
      stream: imagesBloc.categoriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/jar-loading.gif'),
                              image: NetworkImage(categories[index].imgUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black38,
                            ),
                          ),
                          Positioned(
                            left: 30.0,
                            bottom: 30.0,
                            child: Text(
                              categories[index].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // final category = categories[index]['title'].toLowerCase();
                      Navigator.pushNamed(context, 'images',
                          arguments: categories[index].name);
                    },
                  ),
                  SizedBox(height: 20.0)
                ],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createHeader() {
    return Container(
      // height: 3.0,
      margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Categorías',
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
