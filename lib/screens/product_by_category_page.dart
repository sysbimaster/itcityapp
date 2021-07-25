import 'package:flutter/material.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/components/product_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:share/share.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductByCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  ProductByCategoryPage(
      {Key key, @required this.categoryId, @required this.categoryName,})
      : super(key: key);
  @override
  _ProductByCategoryPageState createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
  TextEditingController tcontroller = TextEditingController();


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:AppBar(
          backgroundColor: AppColors.LOGO_ORANGE,
          title: Image.asset(
            'assets/images/logo_home.png',
            width: 130,
            height: 55,
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/cart', (route) => false);
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.WHITE,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: AppColors.WHITE,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // IconButton(onPressed: (){
                      //   Navigator.of(context).pop();
                      // }, icon: Icon(Icons.arrow_back_ios,color: AppColors.LOGO_ORANGE,)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SearchPage()));
                        },
                        child: Container(
                          height: 34,
                          width: MediaQuery.of(context).size.width * .90,
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
                                  padding: EdgeInsets.only(right: 20),
                                ),
                                hintStyle:
                                Theme.of(context).inputDecorationTheme.hintStyle),
                          ),
                        ),
                      ),
                      // IconButton(onPressed: (){
                      //   Navigator.popAndPushNamed(context, '/cart');
                      // }, icon: Icon(Icons.shopping_cart_outlined,color: AppColors.LOGO_ORANGE,)),
                    ]),
              ),
            ),
          ),
        ),
        body: ProductListByCategory(widget.categoryId,));
  }
}

class ProductListByCategory extends StatefulWidget {
  final int categoryId;

  ProductListByCategory(this.categoryId);
  @override
  _ProductListByCategoryState createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {
  String country;
  String currency;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductByCategoryId(widget.categoryId,this.currency));
  }
  List<Product> products = [];

  @override
  void initState() {
    getCountry();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productstate) {
      return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        print('State of product list by category =>' + productstate.toString());

        products = BlocProvider.of<ProductBloc>(context).productListByCategory;

        // List<Brands> brand = BlocProvider.of<HomeBloc>(context).brands;
        if (productstate is ProductByCategoryIdLoadingState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height ,
            color: AppColors.WHITE,
            child: Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                )),
          );
        }
        if (state is BrandDetailsLoadingState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height ,
            color: AppColors.WHITE,
            child: Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                )),
          );
        }

        if (products.length == 0) {
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
          return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 150,color: AppColors.GREY,),
                  SizedBox(height:10),
                  Text("SORRY!",style: TextStyle(
                      color: AppColors.GREY_TEXT,fontSize: 50
                  ),),
                  Text("We could not find any products . Please try again later",style: TextStyle(
                      color: AppColors.GREY_TEXT,fontSize: 20
                  ),textAlign: TextAlign.center,)
                ],
              ));
        }
        return Container(
          color: AppColors.WHITE,
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: GridView.builder(

                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .65,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(currency: this.currency,product: products[index],);
                }),
          ),
        );
      });
    });
  }
}
