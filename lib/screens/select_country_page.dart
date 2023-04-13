import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({Key? key}) : super(key: key);

  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  String? userId ;
  String? token = '';
  String? currency;
  String? country;
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("customerId");
    token = prefs.getString("token");
    currency = prefs.getString('currency');
    country = prefs.getString('country');
    //   userId = await _flutterSecureStorage.read(key: "customerId");
    //  token = await _flutterSecureStorage.read(key: "token");
  }
  @override
  void initState() {
    getEmail();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                width: 250,
                height: 130,
              ),
              Container(
                constraints: new BoxConstraints(
                  minHeight: 50,
                  minWidth: MediaQuery.of(context).size.width * .80,
                ),
                decoration: BoxDecoration(
                  color: AppColors.LOGO_ORANGE,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),

                child: Center(
                    child: Text(
                  "Select Country",
                  style: TextStyle(fontSize: 22, color: AppColors.WHITE),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Saudi Arabia");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Saudi Arabia",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/saudiArabia.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Bahrain");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bahrain",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/bahrain.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Kuwait");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kuwait",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/kuwait.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Oman");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Oman",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/oman.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Philippines");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Philippines",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/philippines.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "Qatar");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Qatar",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/qatar.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () async {
                  showDialogCart(context, "UAE");
                },
                child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 60,
                    minWidth: MediaQuery.of(context).size.width * .83,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UAE",
                            style: TextStyle(
                                color: AppColors.LOGO_BLACK, fontSize: 22),
                          ),
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/country/uae.png')
                                  )
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
showDialogCart(BuildContext context,String Country) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('customerId') != null && prefs.getString('country') != Country){
    showDialog(context: context, builder:(_) => new Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 18.0,
              ),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Text(
                            "Changing Currency / Country will Clear your cart. Do you want to proceed",
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.black),textAlign: TextAlign.center,),
                      ) //
                  ),
                  SizedBox(height: 24.0),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: Text(
                        "YES",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      saveandgoHomePage(context, Country);
                      BlocProvider.of<CartBloc>(context).add(RemoveAllProductFromCartEvent(prefs.getString('customerId')));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginPageNew()),
                      // );
                    },
                  )
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }else {
    saveandgoHomePage(context, Country);
  }
}
saveandgoHomePage(BuildContext context,String Country) async{
if(Country == "Saudi Arabia"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Saudi Arabia");
  prefs.setString('currency', "SAR");
  Navigator.popAndPushNamed(context, "/home");
}else if(Country == "Bahrain"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Bahrain");
  prefs.setString('currency', "BHD");
  Navigator.popAndPushNamed(context, "/home");
} else if(Country == "Kuwait"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Kuwait");
  prefs.setString('currency', "KWD");
  Navigator.popAndPushNamed(context, "/home");
}else if(Country == "Oman"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Oman");
  prefs.setString('currency', "OMR");
  Navigator.popAndPushNamed(context, "/home");
} else if(Country == "Philippines"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Philippines");
  prefs.setString('currency', "PHP");
  Navigator.popAndPushNamed(context, "/home");
}else if(Country == "Qatar"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Qatar");
  prefs.setString('currency', "QAR");
  Navigator.popAndPushNamed(context, "/home");
} else if(Country == "UAE"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "UAE");
  prefs.setString('currency', "AED");
  Navigator.popAndPushNamed(context, "/home");
}else {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Something went wrong, please try again."),
  ));
}
}
