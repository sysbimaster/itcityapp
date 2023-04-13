import 'dart:math';

import 'package:flutter/material.dart';

import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/components/deals_card_new.dart';
import 'package:itcity_online_store/components/list_header.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/deals_full_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyDeals extends StatefulWidget {
  @override
  _DailyDealsState createState() => _DailyDealsState();
}

class _DailyDealsState extends State<DailyDeals> {
  String? currency;
  getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.currency = prefs.getString('currency');
    BlocProvider.of<HomeBloc>(context)
        .add(FetchTodaysDealsByDate(prefs.getString('currency')));

  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.white12,


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
  Random rnd = new Random();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      deals = BlocProvider.of<HomeBloc>(context).dealslist;


      if (state is TodaysDealsLoadingState) {

        return Center(
            child: SpinKitRipple(
          color: Theme.of(context).primaryColor,
          size: 50,
        ));
      }
      if (state is TodaysDealsErrorState) {
        return Container();
      }
      if(deals.isNotEmpty){
        return Container(
          color: AppColors.WHITE,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * .52,
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
                    OutlinedButton(onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DealsFullPage(currency:prefs.getString('currency'),)));
                    }, child: Text('View All',style: TextStyle(fontSize: 16,color: AppColors.LOGO_ORANGE),),style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                    ))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: deals == null ? 0 : deals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DealsCardNew(
                        deal: deals[index],
                        rrating: 3.9+ rnd.nextDouble(),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
                width: 600,
              )
            ],
          ),
        );
      }
      return Center(
          child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));




    });
  }
}
