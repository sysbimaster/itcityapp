import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/computer_collections_card.dart';
import 'package:itcity_online_store/components/list_header.dart';

import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/computer_collections_full.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ComputerCollections extends StatefulWidget {
  const ComputerCollections({Key? key}) : super(key: key);

  @override
  _ComputerCollectionsState createState() => _ComputerCollectionsState();
}

class _ComputerCollectionsState extends State<ComputerCollections> {
  List<Product> computerCollection = [];
  getComputerProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections(prefs.getString('currency')));
    // if( !(BlocProvider.of<HomeBloc>(context).state is ComputerCollectionLoadedState)){
    //   BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections(prefs.getString('currency')));
    // }else {
    //
    // }

  }
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
    getCountry();
    getComputerProducts();
  //  BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections());
    // TODO: implement initState
    super.initState();
  }
  Random rnd = new Random();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        computerCollection =  BlocProvider.of<HomeBloc>(context).computerCollections;

        if (state is ComputerCollectionLoadingState) {

          return Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor,
                size: 50,
              ));
        } else if(state is ComputerCollectionErrorState) {
          return InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections(prefs.getString('currency')));
            },
            child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.refresh)),
          );
        }
        return Container(

          color: AppColors.WHITE,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * .70,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 2, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHeader(
                      headerName: 'Computer Collections',
                      onTap: () async {

                      },
                    ),
                    OutlinedButton(onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ComputerCollectionsFull(currency:prefs.getString('currency'),)));
                    }, child: Text('View All',style: TextStyle(fontSize: 16,color: AppColors.LOGO_ORANGE),),style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height *.20,
                  width: MediaQuery.of(context).size.width,

                  child: Image.asset('assets/images/computerCollectionsbanner.png',fit: BoxFit.fill,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 12,right: 5),
                height: MediaQuery.of(context).size.height * .50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                  //  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: computerCollection == null ? 0 : computerCollection.length,
                    itemBuilder: (BuildContext context,int index){

                      return ComputerCollectionsCard(product: computerCollection[index],currency: currency,rrating: 3.9+ rnd.nextDouble()) ;
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
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    Navigator.of(context).pop();
  }
}


