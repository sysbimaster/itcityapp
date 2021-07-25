import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';

class OrderApi {
  ApiClient _apiclient = ApiClient();

  String _createOrderPath = '/createOrder';
  String _createPurchasePath = '/createPurchase';
  String _getOrderStatusPath = '';
  String _getPurchaseDetails ='/getPurchaseDetailsbyOrderId';

  Future<OrderStatusNew> createOrder(Order order) async {
    String url = _createOrderPath + "?customer_id=${order.customerId}&purchase_id=${order.purchaseId}&total_amnt=${order.totalAmount}&cur=${order.currency}&remarks=${order.remarks??" "} ";
    print(url);
    Response response =
        await _apiclient.invokeAPI(url, 'POST_', {});
    print(response.body.toString());
    return OrderStatusNew.fromJson(jsonDecode(response.body)['data']);
  }

  Future createPurchase(String userId,double subtotal,String currency) async  {
      Response response =
        await _apiclient.invokeAPI(_createPurchasePath+"?user_id=$userId&product_sub_total=$subtotal&cur=$currency", 'POST_', {});

    return jsonDecode(response.body)['data'];
    
  }

  Future<OrderStatus> getOrderStatus(var orderStatusId) async {
    Response response = await _apiclient.invokeAPI(
        _getOrderStatusPath, 'GET', orderStatusId.toJson());
    return OrderStatus.fromJson(jsonDecode(response.body)['data']);
  }
  Future<OrderDetails> getPurchaseDetailsByOrderId(int orderId) async {
    Response response =
        await _apiclient.invokeAPI(_getPurchaseDetails+"?order_id=$orderId", 'POST_', {});
    return OrderDetails.fromJson(jsonDecode(response.body)['data']);
  }
}
