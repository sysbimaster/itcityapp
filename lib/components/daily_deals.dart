import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:itcity_online_store/components/components.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/components/deals_card_new.dart';
import 'package:itcity_online_store/resources/values.dart';

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

     // width: MediaQuery.of(context).size.width,
      color: Colors.white12,

      // child: FittedBox(
      //   fit: BoxFit.contain,
      //   child: Column(

      //     children: [
      //       Container(
      //           padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text('Deal of the Day',
      //                 style: (TextStyle(
      //                   color: Colors.white,
      //                   // fontFamily: 'YanoneKaffeesatz',
      //                   fontFamily: 'RobotoSlab',
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.w800,
      //                 ))),
      //             SizedBox(width: 200),
      //             Container(
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(60),
      //                   color: Colors.white,
      //                 ),
      //                 padding: EdgeInsets.all(7),
      //                 child: Text(
      //                   'View All',
      //                   style: TextStyle(fontWeight: FontWeight.bold),
      //                 ))
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [DealsList(), TimerApp()],
      //       ),
      //     ],
      //   ),
      // ),
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchTodaysDealsByDate());
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

        color: AppColors.WHITE,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * .47,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 10, 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListHeader(
                    headerName: 'Best Deals',
                    onTap: () {},
                  ),
                  OutlinedButton(onPressed: (){}, child: Text('View All',style: TextStyle(fontSize: 16),),style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                  ))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .37,
              
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: deals == null ? 0 : deals.length,
                  itemBuilder: (BuildContext context,int index){
                    return DealsCardNew( deal: deals[index],);
              }),
            ),
            SizedBox(
              height: 10,
              width: 600,
            )

          ],
        ),
      ) ;
    });
  }
}
