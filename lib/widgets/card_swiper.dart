import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:frases_toda_ocasion/bloc/provider.dart';
import 'package:frases_toda_ocasion/models/image_model.dart';

class CardSwiper extends StatelessWidget {
  final List<ImageModel> images;

  CardSwiper({@required this.images});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final ImagesBloc imagesBloc = Provider.of(context);

    return Swiper(
      layout: SwiperLayout.STACK,
      itemWidth: _screenSize.width * 0.85,
      itemHeight: double.infinity,
      itemCount: images.length,
      index: 0,
      onIndexChanged: (index) {
        imagesBloc.changeImageIndex(index);
      },
      control: new SwiperControl(
        padding: EdgeInsets.all(35.0),
        color: Color.fromRGBO(255, 255, 255, 0.9),
      ),
      itemBuilder: (BuildContext context, int index) {
        // movies[index].uniqueId = '${movies[index].id}-mainCard';
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: GestureDetector(
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.png'),
              image: NetworkImage(images[index].imageUrl),
              fit: BoxFit.fill,
            ),
            onTap: () {
              // Navigator.pushNamed(context, 'details',
              //     arguments: movies[index]);
            },
          ),
        );
      },
      // pagination: new SwiperPagination(),
      // control: new SwiperControl(),
    );
  }

  // void _itemChanged(int index) {
  //   imagesBloc.changeImageIndex(index);
  //   // print(index);
  // }
}
