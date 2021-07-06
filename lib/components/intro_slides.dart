import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:itcity_online_store/screens/screens.dart';

class IntroSlides extends StatefulWidget {
  IntroSlides({Key key}) : super(key: key);

  @override
  _IntroSlidesState createState() => _IntroSlidesState();
}

class _IntroSlidesState extends State<IntroSlides> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "Enjoy Online Shopping",
          description: "Enjoy Best online shopping experience with us",
          backgroundImage: "assets/images/slides/1.png",
          backgroundImageFit: 	BoxFit.cover,
          heightImage: 100,
          widthImage: 300,
          styleTitle: TextStyle(fontSize: 30, color: Colors.white),
          styleDescription: TextStyle(fontSize: 25, color: Colors.white)),
    );
    slides.add(
      new Slide(
          title: "Amazing range Product",
          description: "Products available at affordable price for you",
          backgroundImage: "assets/images/slides/3.png",
          backgroundImageFit: 	BoxFit.cover,
          heightImage: 300,
          widthImage: 300,
          styleTitle: TextStyle(fontSize: 30, color: Colors.white),
          styleDescription: TextStyle(fontSize: 25, color: Colors.white)),
    );
    slides.add(
      new Slide(
          backgroundColor: Colors.white,
          title: "Best Products",
          description:
              "Select and buy then top brand products from us with warranty",
          backgroundImage: "assets/images/slides/2.png",
          backgroundImageFit: 	BoxFit.cover,
          styleTitle: TextStyle(fontSize: 30, color: Colors.white),
          styleDescription: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context,'/home' );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: IntroSlider(
          slides: this.slides,
          colorDot: Colors.deepOrangeAccent,
          onDonePress: this.onDonePress,
          onSkipPress: this.onDonePress,
        ));
  }
}
