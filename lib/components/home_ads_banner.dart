import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/constants.dart';
class HomeAdsBanner extends StatefulWidget {
  int index;
  List<HomeAds> imageAds = [];
   HomeAdsBanner({Key key,this.index,this.imageAds}) : super(key: key);

  @override
  _HomeAdsBannerState createState() => _HomeAdsBannerState();
}

class _HomeAdsBannerState extends State<HomeAdsBanner> {


  @override
  void initState() {
  //  BlocProvider.of<HomeBloc>(context).add(FetchHomeAds());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
      //  widget.imageAds = BlocProvider.of<HomeBloc>(context).homeadslist;
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

          height: MediaQuery.of(context).size.width * .40,
          width: MediaQuery.of(context).size.width,

          child: Image.network(widget.imageAds[widget.index]==null ? " " : homeAds + widget.imageAds[widget.index].image,fit: BoxFit.contain,),

        ): Center(
            child: SpinKitRipple(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      },
    );
  }
}



