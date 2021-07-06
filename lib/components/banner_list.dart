import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        return Container();
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
       // color: Colors.deepOrangeAccent,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
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
                        Container(
                          width: MediaQuery.of(context).size.width * .99,
                          child: FittedBox(
                            child: Image.network(
                                item == null ? '' : homeImage + item.imageName),
                            fit: BoxFit.fill,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: image.map((url) {
            //     int index = image.indexOf(url);
            //     return Container(
            //       width: 8.0,
            //       height: 8.0,
            //       margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: _current == index
            //             ? Colors.white
            //             : Colors.grey,
            //       ),
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      );
    });
  }
}
