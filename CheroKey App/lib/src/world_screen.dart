// import 'package:chero_key/src/start_screen.dart';
import 'package:chero_key/service/game_and_level_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chero_key/src/level_select_screen.dart';
import 'package:provider/provider.dart';

class WorldScreen extends StatelessWidget {
  static const String route = '/world_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/wooden bg.png',
              fit: BoxFit.cover,
            ),
          ),

          Placer(
              name: 'assets/images/select_world_assets/book bg.png',
              bottom: 0.0,
              right: -14.0,
              height: 120.0,
              width: 120.0),
          Placer(
              name: 'assets/images/select_world_assets/select world books.png',
              top: -70.0,
              left: 0.0,
              height: 230.0,
              width: 230.0),
          Placer(
              name: 'assets/images/select_world_assets/start screen pen.png',
              bottom: -65.0,
              left: -70.0,
              height: 200.0,
              width: 200.0),
          Placer(
              name: 'assets/images/select_world_assets/eraser.png',
              bottom: 100.0,
              left: -10.0,
              height: 80.0,
              width: 80.0),
          Placer(
              name: 'assets/images/select_world_assets/start screen clip1.png',
              top: -10.0,
              right: 180.0,
              height: 80.0,
              width: 70.0),
          Placer(
              name: 'assets/images/select_world_assets/start screen clip2.png',
              top: 50.0,
              left: -38.0,
              height: 80.0,
              width: 70.0),
          Placer(
              name: 'assets/images/select_world_assets/t bg.png',
              top: -25.0,
              right: 0.0,
              height: 90.0,
              width: 90.0),
          Placer(
              name:
                  'assets/images/select_world_assets/start screen top shadow.png',
              top: -60.0,
              left: 0.0,
              height: 240.0,
              width: MediaQuery.of(context).size.width),
          Container(
            width: 70,
            child: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: Image(
                image: AssetImage(
                    'assets/images/select_world_assets/back arrow.png'),
              ),
            ),
          ),

          //For the cards in the middle
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CardCarousel(),
          ),
        ],
      ),
    );
  }
}
//============= Methods we've created to group  widgets ===============

//Function for placing images on the screen
class Placer extends StatelessWidget {
  Placer(
      {this.name,
      this.top,
      this.bottom,
      this.left,
      this.right,
      this.width,
      this.height});

  final String name;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: width,
        height: height,
        child: Image.asset(name),
      ),
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }
}

//Carter, 30 Jan - used to make a carousel list
class CardCarousel extends StatefulWidget {
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final CarouselController _controller = CarouselController();
  List<Widget> _cards = <Widget>[];
  int _index = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List titles = [
      "The First Fire",
      "How The World Was Made",
      "The Origin Of The Strawberry"
    ];
    final List colorPaths = [
      "assets/images/select_level_assets/category color9 level selection.png",
      "assets/images/select_level_assets/category color8 level selection.png",
      "assets/images/select_level_assets/category color2 level selection.png"
    ];
    final List iconPaths = [
      "assets/images/select_level_assets/Fire Icon.png",
      "assets/images/select_level_assets/World icon.png",
      "assets/images/select_level_assets/Strawberry icon.png"
    ];
    final List icons = [
      Container(),
      Icon(Icons.public_rounded, color: Colors.green[700], size: 120.0),
      Image.asset(
        "assets/images/select_world_assets/strawberry.png",
        scale: 15,
      )
    ];
    return Consumer<GameAndLevelData>(builder: (context, data, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: _cards = List<Widget>.generate(3, (i) {
              return GestureDetector(
                onTap: () {
                  data.setWorldInfo =
                      titles[i];
                  data.setColorPath =
                      colorPaths[i];
                  data.setIconPath =
                      iconPaths[i];
                  Navigator.pushNamed(context, LevelSelectScreen.route);
                },
                child: Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                        image: AssetImage(
                            'assets/images/select_world_assets/${titles[i]}.png'),
                        height: 300,
                        fit: BoxFit.contain),

                    //World title on world cards
/*                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                titles[i],
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),*/
                  ],
                )),
              );
            }),
            options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                height: 300.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _index = index + 1;
                  });
                },
                viewportFraction: 0.38),

            carouselController: _controller,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Select World',
                          style: TextStyle(
                              color: Colors.amber[50],
                              fontSize: 20.0),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          _index.toString() + " / 3",
                          key: UniqueKey(),
                          style: TextStyle(
                              color: Colors.amber[50],
                              fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
