import 'package:flutter/material.dart';

import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:easy_localization/easy_localization.dart';
class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchBrandDetails());
  }
 @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print('state of home=> ' + state.toString());
        List<Brands> brandlist = BlocProvider.of<HomeBloc>(context).brands;
        if (state is HomeInitial) {
          print('initial');
          BlocProvider.of<HomeBloc>(context).add(FetchBrandDetails());
        }
        if (state is BrandDetailsLoadingState) {
          print('circular');

          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if((context.locale.toString()) == 'ar'){
        return Container(
            height: 300.0,
            color: Colors.grey[200],
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 180,
                itemCount: brandlist == null ? 0 : brandlist.length,
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Container(
                    child: Text('brand =' +
                        (brandlist == null ? '' : brandlist[index].brandsNameArabic)),
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //   image: NetworkImage(imagesection+brandlist[index].brandImage),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  );
                }));}
      },
    );
  }
}
