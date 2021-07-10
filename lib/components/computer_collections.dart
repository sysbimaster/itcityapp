import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/list_header.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';

import '../constants.dart';

class ComputerCollections extends StatefulWidget {
  const ComputerCollections({Key key}) : super(key: key);

  @override
  _ComputerCollectionsState createState() => _ComputerCollectionsState();
}

class _ComputerCollectionsState extends State<ComputerCollections> {
  List<Product> computerCollection = [];
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        computerCollection =  BlocProvider.of<HomeBloc>(context).computerCollections;
        print("computer length"+computerCollection.length.toString());
        if (state is ComputerCollectionLoadingState) {
          print('circular');
          return Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor,
                size: 50,
              ));
        } else if(state is ComputerCollectionErrorState) {
          return InkWell(
            onTap: (){
              BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections());
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
                      headerName: 'Computer Collections',
                      onTap: () {},
                    ),
                    OutlinedButton(onPressed: (){}, child: Text('View All',style: TextStyle(fontSize: 16),),style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height *.20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Image.asset('assets/images/computerCollectionsbanner.png',fit: BoxFit.fill,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 12,right: 5),
                height: MediaQuery.of(context).size.height * .40,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: computerCollection == null ? 0 : computerCollection.length,
                    itemBuilder: (BuildContext context,int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ProductDetailPage(
                              productId: computerCollection[index].productId,
                            );
                          }));
                        },
                        child: Card(
                          elevation: 2,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height * 50,
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: Column(

                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 160.0,
                                          width: 110.0,
                                          //margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(computerCollection == null
                                                  ? ''
                                                  : productImage + computerCollection[index].productImage,),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              computerCollection == null
                                                  ? 'Computer'
                                                  : 'Computer',
                                              maxLines: 2,
                                              // softWrap: false,
                                              // overflow: TextOverflow.fade,

                                              style: (TextStyle(
                                                // fontFamily: 'YanoneKaffeesatz',
                                                color: AppColors.LOGO_ORANGE,

                                                fontSize: 15,

                                              )),textAlign: TextAlign.left,)),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              computerCollection == null
                                                  ? ''
                                                  : computerCollection[index].productName,
                                              maxLines: 2,
                                              // softWrap: false,
                                              // overflow: TextOverflow.fade,

                                              style: (TextStyle(
                                                // fontFamily: 'YanoneKaffeesatz',
                                                color: AppColors.LOGO_BLACK,

                                                fontSize: 15,

                                              )),textAlign: TextAlign.left,)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'KWD ' +
                                                      computerCollection[index].productPrice.toString(),
                                                  style: (TextStyle(
                                                    //  fontFamily: 'RobotoSlab',
                                                    fontSize: 14,

                                                    color: AppColors.LOGO_BLACK,
                                                    fontWeight: FontWeight.w600,
                                                  )),textAlign: TextAlign.left,)),



                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(5),
                                            child: SizedBox(
                                              height: 32,
                                              width: MediaQuery.of(context).size.width *.42,
                                              child: TextButton(
                                                onPressed: null,
                                                child: Text('ADD TO CART', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                                style: ButtonStyle(
                                                    foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                                                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.LOGO_ORANGE),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(14.0),
                                                            side: BorderSide(color:AppColors.LOGO_ORANGE)
                                                        )
                                                    )
                                                ),),
                                            ))
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
