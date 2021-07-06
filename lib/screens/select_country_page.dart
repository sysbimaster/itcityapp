import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({Key key}) : super(key: key);

  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
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
                  saveandgoHomePage(context, "Saudi Arabia");
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
                  saveandgoHomePage(context, "Bahrain");
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
                  saveandgoHomePage(context, "Kuwait");
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
                  saveandgoHomePage(context, "Oman");
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
                  saveandgoHomePage(context, "Philippines");
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
                  saveandgoHomePage(context, "Qatar");
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
                  saveandgoHomePage(context, "UAE");
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
saveandgoHomePage(BuildContext context,String Country) async{
if(Country == "Saudi Arabia"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Saudi Arabia");
  prefs.setString('currency', "SAR");
  Navigator.popAndPushNamed(context, "/home");
}else if(Country == "Bahrain"){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', "Bahrain");
  prefs.setString('currency', "SAR");
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
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text("Something went wrong, please try again."),
  ));
}
}
