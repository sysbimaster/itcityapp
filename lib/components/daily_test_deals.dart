import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:itcity_online_store/components/components.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyDeals extends StatefulWidget {
  @override
  _DailyDealsState createState() => _DailyDealsState();
}

class _DailyDealsState extends State<DailyDeals> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],


      child: DealsList(),
    );
  }
}

class DealsList extends StatefulWidget {
  @override
  _DealsListState createState() => _DealsListState();
}

class _DealsListState extends State<DealsList> {
  List<DealOfTheDay> deals = [];
  getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<HomeBloc>(context).add(FetchTodaysDealsByDate(prefs.getString('currency')));
  }

  @override
  void initState() {
   getCategory();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      deals = BlocProvider.of<HomeBloc>(context).dealslist;
      // print('state of deal>>>>>' + state.toString());

      if (state is TodaysDealsLoadingState) {
        print('circular');
        return Center(
            child: SpinKitCircle(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      }
      // print('deals length=>>>>>>>>' + deals.length.toString());

      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: EdgeInsets.symmetric(vertical:4),

        child: ListView.builder(
          scrollDirection:Axis.horizontal,
          // options: CarouselOptions(
          //     onPageChanged: (index, reason) {
          //       setState(() {});
          //     },
          //     autoPlay: true,
          //     viewportFraction: 1,
          //     autoPlayAnimationDuration: Duration(seconds: 3),
          //     // aspectRatio: 2.0,
          //     enableInfiniteScroll: false,
          //     scrollDirection: Axis.horizontal),
          itemCount: deals == null ? 0 : deals.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 3),
              child: DealsCard(
                deal: deals[index],
              ),
            );
          },
        ),
      );
    });
  }
}
