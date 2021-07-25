import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/HomeAds.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';

import '../constants.dart';

class FirstAdHome extends StatefulWidget {
  int index;
  List<HomeAds> imageAds = [];

  FirstAdHome({Key key, this.index, this.imageAds}) : super(key: key);

  @override
  _FirstAdHomeState createState() => _FirstAdHomeState();
}

class _FirstAdHomeState extends State<FirstAdHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeAdsLoadingState) {
          print('circular');
          return Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor,
                size: 50,
              ));
        } else if(state is HomeAdsErrorState) {
          return InkWell(
            onTap: (){
              BlocProvider.of<HomeBloc>(context).add(FetchHomeAds());
            },
            child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.refresh)),
          );
        }
        return widget.imageAds.isNotEmpty ? Container(
          color: AppColors.WHITE,
          height: MediaQuery.of(context).size.height * .20,
          width: MediaQuery.of(context).size.width,


          child: Center(
            child: Container(

              width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * .18,
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageAds[widget.index]==null ? " " : homeAds + widget.imageAds[widget.index].image),
                    fit: BoxFit.cover
                  )
                ),

          ),

        )): Center(
            child: SpinKitRipple(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      },
    );
  }
}
