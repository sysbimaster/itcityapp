import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/constants.dart';

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<Category>? categoryList =[];
  @override
  void initState() {
    super.initState();
   // BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      categoryList = BlocProvider.of<CategoryBloc>(context).categoryList;
      if (state is CategoryLoadingState) {
        return Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ));
      }


      return Container(
        height: 135.0,
        color: AppColors.WHITE,
        child: Padding(
          padding: EdgeInsets.only(left: 2),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: categoryList == null ? 0 : categoryList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
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
                  child: Column(


                    children: [

                      Container(
                          width: 75,
                          height: 80,

                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.LOGO_ORANGE,width: 2.5),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(categoryList == null
                                  ? ''
                                  : categoryImage +
                                  categoryList![index].categoryImage!),
                              fit: BoxFit.contain,
                            ),
                          )),
                      Container(
                        width: 75,
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
                                fontSize: 12,
                                color: AppColors.LOGO_BLACK,
                                fontWeight: FontWeight.w500,
                              )),textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
