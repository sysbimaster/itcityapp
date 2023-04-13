import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/orderHistoryModel.dart';
import 'package:itcity_online_store/api/models/product_order_details.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';

class OrderHistoryDetailsPage extends StatefulWidget {
  OrderHistoryDetailsPage(
      {Key? key, this.orderHistoryModel, this.index, this.status})
      : super(key: key);

  OrderHistoryModel? orderHistoryModel;
  int? index;
  String? status;

  @override
  State<OrderHistoryDetailsPage> createState() =>
      _OrderHistoryDetailsPageState();
}

class _OrderHistoryDetailsPageState extends State<OrderHistoryDetailsPage> {


  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(GetOrderDetailsEvent(widget.orderHistoryModel!.data![widget.index!].orderId));
    // TODO: implement initState
    super.initState();
  }
 ProductOrderDetails? productOrderDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.orderHistoryModel!.data![widget.index!].orderId.toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Id : " +
                              widget.orderHistoryModel!.data![widget.index!].orderId
                                  .toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(widget.orderHistoryModel!.data![widget.index!].createdAt!),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Your Order is " + widget.status!,
                          style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shipping Address ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(widget
                            .orderHistoryModel!.data![widget.index!].shippingName!),
                        Text(widget
                            .orderHistoryModel!.data![widget.index!].shippingAddress!),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Remarks ",
                          style: TextStyle(fontSize: 20),
                        ),
                        widget.orderHistoryModel!.data![widget.index!].remarks != null
                            ? Text(
                                widget.orderHistoryModel!.data![widget.index!].remarks!)
                            : Text('No Remarks'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Total",
                          style: TextStyle(fontSize: 23),
                        ),
                        Text(
                            widget.orderHistoryModel!.data![widget.index!].currency!+" "+widget.orderHistoryModel!.data![widget.index!].totalAmnt!,style: TextStyle(fontSize: 23))
                           ,
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Details ",
                          style: TextStyle(fontSize: 20),
                        ),
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            if(state is GetOrderDetailsLoadedState){
                             productOrderDetails = BlocProvider.of<OrderBloc>(context).productOrderDetails;
                              return  ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: productOrderDetails!.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width * .55,
                                            child: Text(productOrderDetails!.data![index].name!,style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.GREY_TEXT,
                                              fontFamily: 'Myriad-semi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                              textAlign: TextAlign.left,)),
                                        Text(productOrderDetails!.data![index].qty.toString() + " X "+widget
                                            .orderHistoryModel!.data![widget.index!].currency!+ " " + productOrderDetails!.data![index].price.toString(),style: TextStyle(
                                          fontSize: 17,
                                          color: AppColors.GREY_TEXT,
                                          fontFamily: 'Myriad-semi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                          textAlign: TextAlign.left,)
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            if(state is GetOrderDetailsLoadingState){
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Please Reach out to us For any Queries ',style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Phone:  +965 90019287',style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
