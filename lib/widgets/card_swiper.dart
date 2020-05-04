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
      layout: SwiperLayout.DEFAULT,
      // itemWidth: _screenSize.width * 0.85,
      // itemHeight: double.infinity,
      itemCount: images.length,
      index: 0,
      onIndexChanged: (index) {
        imagesBloc.changeImageIndex(index);
        final downloads = imagesBloc.imagesList[index].downloads;
        imagesBloc.changedownloads(downloads);
      },
      control: new SwiperControl(
        padding: EdgeInsets.all(10.0),
        color: Color.fromRGBO(255, 255, 255, 0.9),
      ),
      itemBuilder: (BuildContext context, int index) {
        // movies[index].uniqueId = '${movies[index].id}-mainCard';
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GestureDetector(
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.png'),
              image: NetworkImage(images[index].imageUrl),
              fit: BoxFit.fill,
            ),
            onTap: null,
          ),
        );
      },
    );
  }
}
