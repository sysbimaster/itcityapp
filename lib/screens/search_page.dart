import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/bloc/search_bloc.dart';
import 'package:itcity_online_store/components/product_list.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<SearchBloc>(context).add(SearchReset());
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox.shrink(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchTermEvent(value));
                  },
                  decoration: InputDecoration(
                      // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: true,
                      hoverColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Search Product, brands and more",
                      suffixIcon: IconButton(
                        onPressed: () {
                          // controller.
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchTermEvent(controller.value.text));
                        },
                        icon: Icon(Icons.search),
                      ),
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchSuccessState) {
              return GridView.builder(
                  itemCount: state.product.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .53,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductList(product: state.product[index]);
                  });
            } else if (state is SearchLoadingState) {
              return SpinKitRing(
                color: Colors.black,
                size: 20,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
