import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/orderHistoryModel.dart';
import 'package:itcity_online_store/blocs/OrderHistory/order_history_bloc.dart';
import 'package:itcity_online_store/screens/OrderHistoryDetailsPage.dart';

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key? key,this.custId}) : super(key: key);
  String? custId;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  OrderHistoryModel? orderHistoryModel;
  @override
  void initState() {
    if(widget.custId !=null){
      BlocProvider.of<OrderHistoryBloc>(context).add(GetOrderHistory(widget.custId));
    }

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order History"),
          centerTitle: true,
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoaded) {
              orderHistoryModel =
                  BlocProvider.of<OrderHistoryBloc>(context).orderHistoryModel;
              return ListView.builder(
                itemCount: orderHistoryModel!.data!.length,
                  itemBuilder: (context, index) {
                  String status = '';
                  switch(int.parse(orderHistoryModel!.data![index].orderStatusId!)){
                    case 1 : status = 'Processing';
                    break;
                    case 2 : status = 'Shipped';
                    break;
                    case 3 : status = 'Cancelled';
                    break;
                    case 4 : status = 'Complete';
                    break;
                    case 5 : status = 'Denied';
                    break;
                    case 6 : status = 'Cancelled Reversal';
                    break;
                    case 7 : status = 'Failed';
                    break;
                    case 8 : status = 'Refunded';
                    break;
                    case 9 : status = 'Reversed';
                    break;
                    case 10 : status = 'ChargeBack';
                    break;
                    case 11 : status = 'Pending';
                    break;
                    case 12 : status = 'Voided';
                    break;
                    case 13: status = 'Processed';
                    break;
                    case 14 : status = 'Expired';
                    break;

                  }
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return OrderHistoryDetailsPage(orderHistoryModel: orderHistoryModel,index: index,status: status,);
                          }));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(orderHistoryModel!.data![index].orderNumber!,style: TextStyle(fontSize: 20),),
                                  Text(orderHistoryModel!.data![index].createdAt!,style: TextStyle(fontSize: 15),),
                                  Text('Order Status : '+status,style: TextStyle(fontSize: 15),),
                                  Text('Total Amount : '+ orderHistoryModel!.data![index].totalAmnt!,style: TextStyle(fontSize: 15),)




                                ],
                              ),
                              IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  });
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}
