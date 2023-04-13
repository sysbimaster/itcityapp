import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/constants.dart';
class HomeAdsBanner extends StatefulWidget {
  int? index;
  List<HomeAds>? imageAds = [];
   HomeAdsBanner({Key? key,this.index,this.imageAds}) : super(key: key);

  @override
  _HomeAdsBannerState createState() => _HomeAdsBannerState();
}

class _HomeAdsBannerState extends State<HomeAdsBanner> {


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if (state is HomeAdsLoadingState) {

          return Container(

            height: MediaQuery.of(context).size.width * .40,
            width: MediaQuery.of(context).size.width,

            child: Image.asset('assets/images/homebanner.jpeg',fit: BoxFit.contain,),

          );
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
        return widget.imageAds!.isNotEmpty ? Container(

          height: MediaQuery.of(context).size.width * .40,
          width: MediaQuery.of(context).size.width,

          child: Image.network(widget.imageAds![widget.index!]==null ? " " : homeAds + widget.imageAds![widget.index!].image!,fit: BoxFit.contain,),

        ): Container(

          height: MediaQuery.of(context).size.width * .40,
          width: MediaQuery.of(context).size.width,

          child: Image.asset('assets/images/homebanner.jpeg',fit: BoxFit.contain,),

        );
      },
    );
  }
}



