import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';

import '../constants.dart';
import 'list_header.dart';

class MobileCollections extends StatefulWidget {
  
 MobileCollections({Key key}) : super(key: key);

  @override
  _MobileCollectionsState createState() => _MobileCollectionsState();
}

class _MobileCollectionsState extends State<MobileCollections> {
  List<Product> mobileCollection = [];
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchMobileCollections());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    mobileCollection =  BlocProvider.of<HomeBloc>(context).mobileColletions;
    print("mobile length"+productImage + mobileCollection[0].productImage);

    if (state is MobileCollectionLoadingState) {
      print('circular');
      return Center(
          child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));
    } else if(state is MobileCollectionErrorState) {
      return InkWell(
        onTap: (){
          BlocProvider.of<HomeBloc>(context).add(FetchMobileCollections());
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
            padding: const EdgeInsets.fromLTRB(5, 2, 10, 5),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListHeader(
                  headerName: 'Mobile Collections',
                  onTap: () {},
                ),
                OutlinedButton(onPressed: (){}, child: Text('View All',style: TextStyle(fontSize: 16),),style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                ))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *.40,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/mobilecollectionsbanner.png',fit: BoxFit.fill,),
          ),
          Container(
          height: MediaQuery.of(context).size.height * .30,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(

              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mobileCollection == null ? 0 : mobileCollection.length,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ProductDetailPage(
                        productId: mobileCollection[index].productId,
                      );
                    }));
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * .33,
                      child: Column(

                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 160.0,
                            width: 100.0,
                            //margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(mobileCollection == null
                                    ? ''
                                    : productImage + mobileCollection[index].productImage,),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  mobileCollection == null
                                      ? ''
                                      : mobileCollection[index].productName,
                                  maxLines: 2,
                                  // softWrap: false,
                                  // overflow: TextOverflow.fade,

                                  style: (TextStyle(
                                    // fontFamily: 'YanoneKaffeesatz',
                                    color: AppColors.LOGO_ORANGE,

                                    fontSize: 15,

                                  )),textAlign: TextAlign.center,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                  'KWD ' +
                                      mobileCollection[index].productPrice.toString(),
                                  style: (TextStyle(
                                    //  fontFamily: 'RobotoSlab',
                                    fontSize: 14,

                                    color: AppColors.LOGO_BLACK,
                                    fontWeight: FontWeight.w600,
                                  )),textAlign: TextAlign.center,)),

                        ],
                      ),
                      ]
                    )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite_border_outlined,color: AppColors.GREY,),
                        ),
                      )
                  ],
                  ),
                );
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
