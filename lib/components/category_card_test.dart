import 'package:flutter/material.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/constants.dart';

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<Category> categoryList =[];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    categoryList =
        BlocProvider.of<CategoryBloc>(context).categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {

      if (state is CategoryLoadingState) {
        print("changed");
      }

      return Container(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList == null ? 0 : categoryList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductByCategoryPage(
                    categoryId: categoryList == null
                        ? 0
                        : categoryList[index].categoryId,
                    categoryName: categoryList == null
                        ? ''
                        : categoryList[index].categoryName,
                  );
                }));
              },
              child: Container(
                width: 100,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 50,
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(categoryList == null
                                ? ''
                                : categoryImage +
                                categoryList[index].categoryImage),
                            fit: BoxFit.fill,
                          ),
                        )),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                            categoryList == null
                                ? ''
                                : categoryList[index].categoryName,
                            overflow: TextOverflow.ellipsis,
                            style: (TextStyle(
                              fontFamily: 'YanoneKaffeesatz',
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                            ))),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
