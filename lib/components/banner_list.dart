import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';

class BannerList extends StatefulWidget {
  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  List<HomeImages> image = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  int _current = 0;
  Widget build(BuildContext context) {
    if (BlocProvider.of<HomeBloc>(context).state is HomeInitial) {
      BlocProvider.of<HomeBloc>(context).add(FetchHomeImages());
    }
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      image = BlocProvider.of<HomeBloc>(context).image;
      if (state is HomeImagesLoadingState) {
        print('circular');
        return Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ));
      } else if(state is HomeImagesErrorState) {
        return InkWell(
          onTap: (){
                BlocProvider.of<HomeBloc>(context).add(FetchHomeImages());
            },
                  child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.refresh)),
        );
      }
      return Container(

        height: MediaQuery.of(context).size.height * .26,
        color: AppColors.WHITE,
        child: Stack(
          children: [
            Container(

              child: CarouselSlider(
                items: image
                    .map((item) =>
                        // Container(
                        //       height: 150.0,
                        //       width: 360.0,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        //         color: Colors.white,
                        //         image: DecorationImage(
                        //           image: NetworkImage(
                        //               item == null ? '' : homeImage + item.imageName),
                        //           fit: BoxFit.fill,
                        //         ),
                        //       ),
                        //     ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProductDetailPage(
                                productId: item.url,
                              );
                            }));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width  ,
                            child: FittedBox(
                              child: Image.network(
                                  item == null ? '' : homeImage + item.imageName),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 250),
                   autoPlayCurve: Curves.ease,
                    // enlargeCenterPage: true,
                    viewportFraction: 2,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Align(
              heightFactor: 5,
              widthFactor: 1,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: image.map((url) {
                    int index = image.indexOf(url);
                    return Container(
                      width: 25.0,
                      height:3.0,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        shape: BoxShape.rectangle,
                        color: _current == index
                            ? AppColors.LOGO_ORANGE
                            : AppColors.WHITE,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
