import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';
import 'package:itcity_online_store/components/mobile_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/mobile_collections_full_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'list_header.dart';

class MobileCollections extends StatefulWidget {
  
 MobileCollections({Key? key}) : super(key: key);

  @override
  _MobileCollectionsState createState() => _MobileCollectionsState();
}

class _MobileCollectionsState extends State<MobileCollections> {
  List<Product> mobileCollection = [];
  getMobileProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<HomeBloc>(context).add(FetchMobileCollections(prefs.getString('currency')));

  }
  Random rnd = new Random();
  String? country;
  String? currency;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
  }
  @override
  void initState() {
    BlocProvider.of<RandomReviewBloc>(context).add(FetchReview());
    getCountry();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    mobileCollection =  BlocProvider.of<HomeBloc>(context).mobileColletions;


    if (state is MobileCollectionLoadingState) {

      return Center(
          child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));
    } else if(state is MobileCollectionErrorState) {
      return InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          BlocProvider.of<HomeBloc>(context).add(FetchMobileCollections(prefs.getString('currency')));
        },
        child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.refresh)),
      );
    }
    return Container(

      color: AppColors.WHITE,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * .50,
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.fromLTRB(5, 2, 10, 5),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListHeader(
                  headerName: 'Mobile Collections',
                  onTap: () {},
                ),
                OutlinedButton(onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MobileCollectionsFullPage(Currency:prefs.getString('currency'),)));
                }, child: Text('View All',style: TextStyle(fontSize: 16,color: AppColors.LOGO_ORANGE),),style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                ))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *.4,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/mobilecollectionsbanner.png',fit: BoxFit.fill,),
          ),
          Container(
          height: MediaQuery.of(context).size.height * .35,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(

              scrollDirection: Axis.horizontal,
             // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mobileCollection == null ? 0 : mobileCollection.length,
              itemBuilder: (BuildContext context,int index){

                return MobileCollectionsCard(product: mobileCollection[index],currency: currency,rrating: 3.9+ rnd.nextDouble());
              }),
            ),
          SizedBox(
            height: 5,
            width: 600,
          )

        ],
      ),
    );
  },
) ;
  }
}
