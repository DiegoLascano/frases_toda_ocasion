import 'package:flutter/material.dart';
import 'package:frases_toda_ocasion/bloc/provider.dart';
import 'package:frases_toda_ocasion/models/image_model.dart';
import 'package:frases_toda_ocasion/widgets/card_swiper.dart';

class ImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context).settings.arguments;

    final imagesBloc = Provider.of(context);
    imagesBloc.fetchImages(category);
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Column(
          children: <Widget>[
            _createStats(imagesBloc),
            Expanded(
              child: _createImages(imagesBloc),
            ),
          ],
        )

        // CustomScrollView(slivers: <Widget>[
        //   _createAppbar(category),
        //   SliverList(
        //     delegate: SliverChildListDelegate(
        //       [
        //         _createImages(imagesBloc),
        //         // _createStats(imagesBloc),
        //       ],
        //     ),
        //   )
        // ]),
        );
  }

  Widget _createAppbar(String category) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 80.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(category,
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        // background: FadeInImage(
        //   placeholder: AssetImage('assets/images/loading.gif'),
        //   image: NetworkImage(movie.getBackgroundImage()),
        //   fadeInDuration: Duration(milliseconds: 200),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  Widget _createImages(ImagesBloc imagesBloc) {
    return StreamBuilder(
      stream: imagesBloc.imagesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final imagesList = snapshot.data;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
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

  Widget _createStats(ImagesBloc imagesBloc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<int>(
            stream: imagesBloc.votesStream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final votes = snapshot.data;
                return Text(votes.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 35.0,
            onPressed: () {
              // HERE GOES THE CODE TO SAVE THE IMAGE TO LOCAL STORAGE
              print(imagesBloc.imagesList[imagesBloc.imageIndex].imageUrl);
            },
          )
        ],
      ),
    );
  }
  // Widget _createItem(BuildContext context, ImageModel image) {
  //   return Card(
  //     child: (image.imageUrl == null)
  //         ? Image(image: AssetImage('assets/images/no-image.png'))
  //         : FadeInImage(
  //             placeholder: AssetImage('assets/images/jar-loading.gif'),
  //             image: NetworkImage(image.imageUrl),
  //             height: 300.0,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //   );
  // }
}
