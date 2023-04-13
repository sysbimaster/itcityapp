import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/category.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/product_by_category_page.dart';
import 'package:itcity_online_store/screens/search_page.dart';

import '../constants.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category>? categoryList =[];
  TextEditingController tcontroller = TextEditingController();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        categoryList = BlocProvider.of<CategoryBloc>(context).categoryList;
        if (state is CategoryLoadingState) {
          return Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor,
                size: 50,
              ));
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.WHITE,

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(5),
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    IconButton(onPressed: (){
                      Navigator.of(context).maybePop();
                    }, icon: Icon(Icons.arrow_back_ios,color: AppColors.LOGO_ORANGE,)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SearchPage()));
                      },
                      child: Container(
                        height: 34,
                        width: MediaQuery.of(context).size.width * .75,
                        alignment: Alignment.bottomCenter,
                        //margin: EdgeInsets.fromLTRB(5, 10, 15, 10),
                        child: TextField(
                          enabled: false,
                          controller: tcontroller,
                          decoration: InputDecoration(
                            // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                              fillColor: AppColors.GREY,
                              contentPadding: EdgeInsets.fromLTRB(25, 2, 25, 2),
                              filled: true,
                              hoverColor: Colors.grey,
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "Search Product, brands and more",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                padding: EdgeInsets.only(right: 20), onPressed: null,
                              ),
                              hintStyle:
                              Theme.of(context).inputDecorationTheme.hintStyle),
                        ),
                      ),
                    ),

                  ]),
            ),
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                      child: Text('Categories',style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 26),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: categoryList!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: .92,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ProductByCategoryPage(
                                    categoryId: categoryList == null
                                        ? 0
                                        : categoryList![index].categoryId,
                                    categoryName: categoryList == null
                                        ? ''
                                        : categoryList![index].categoryName,
                                  );
                                }));
                              },
                              child: Container(
                               // color: AppColors.GREY,
                               // width: MediaQuery.of(context).size.width ,
                                child: Column(
                                  children: [

                                    Container(
                                       width: MediaQuery.of(context).size.width *.23,
                                       height: MediaQuery.of(context).size.width * .23,

                                        //padding: EdgeInsets.fromLTRB(10, 10, 20, 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.LOGO_ORANGE,width: 2.5),
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(categoryList == null
                                                ? ''
                                                : categoryImage +
                                                categoryList![index].categoryImage!),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        )),
                                    Container(
                                      //width: 75,
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Text(
                                          categoryList == null
                                              ? ''
                                              : categoryList![index].categoryName!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: (TextStyle(
                                            // fontFamily: 'YanoneKaffeesatz',
                                            fontSize: 15,
                                            color: AppColors.LOGO_BLACK,
                                            //fontWeight: FontWeight.w500,
                                          )),textAlign: TextAlign.center,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            },

          ),
        );
      },
    );
  }
}
