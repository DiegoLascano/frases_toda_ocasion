import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:frases_toda_ocasion/bloc/provider.dart';
import 'package:frases_toda_ocasion/models/category_model.dart';

const testDevice = 'MobileID';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nativeAdController = NativeAdmobController();
  double _nativeAdHeight = 0;

  StreamSubscription _subscription;

  // Test Native ID
  static const _nativeUnitID = "ca-app-pub-3940256099942544/8135179316";
  // Native Id
  // static const _nativeUnitID = "ca-app-pub-1500612778036594/4904126837";

  // Test Interstitial ID
  static const _interstitialUnitID = "ca-app-pub-3940256099942544/8135179316";
  // Interstitial ad ID
  // static const _interstitialUnitID = "ca-app-pub-1500612778036594/9248418728";

  static MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>[
      'medical',
      'medico',
      'doctor',
      'score',
      'mama',
      'gestacional',
      'gestational',
      'calculator'
    ],
    // contentUrl: 'https://flutter.io',
    childDirected: false,
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: _interstitialUnitID,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.closed) {
          _interstitialAd?.dispose();
          _interstitialAd = createInterstitialAd()..load();
          print("InterstitialAd event $event");
        }
      },
    );
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _nativeAdHeight = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _nativeAdHeight = 160;
        });
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

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
                              image: NetworkImage(categories[index].imageUrl),
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
