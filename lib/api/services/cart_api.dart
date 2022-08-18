import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CartApi {
  ApiClient _apiclient = ApiClient();

  String _taxDetailsPath = '/getTaxDetailsbyTaxPercentage';
  String _addProductToCartPath = '/addToCart';
  String _removeAllProductFromCartPath = '/removeAllFromCart';
  String _removeProductFromCartPath = '/removeProductFromCartByProductId';
  String _getCartDetailsPath = '/getCartDetailsByUsername';

  Future<List<Tax>> getTaxDetails(String taxPercentage) async {
    Response response = await _apiclient.invokeAPI(
        '$_taxDetailsPath?tax_percentage=$taxPercentage', 'GET', null);
    return Tax.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<bool?> addProductToCart(Cart cart) async {
    int uid = int.parse(cart.userId!);
    print(cart.userId);
    String cartJson =
        '{"user_id" : $uid,"cur" : "${cart.currency}" ,"cart_data" : "${cart.cartData}","prod_count" : ${cart.productCount},"prod_price" : "${cart.productPrice.toString()}"}';
    print(cartJson);
    Response response =
        await _apiclient.invokeAPI(_addProductToCartPath, 'POST', cartJson);
    print("Adding Item to Cart" + response.body);
    return (jsonDecode(response.body)['success']);
  }

  Future<List<Cart>> removeAllProductFromCart(String userId) async {
    String json = '{"user_id":$userId}';
    print(json);
    Response response =
        await _apiclient.invokeAPI(_removeAllProductFromCartPath+"?user_id=$userId", 'POST_', {});
    print(jsonDecode(response.body)['data']);
    return Cart.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Cart>> removeProductFromCart(
      String? userId, String? cartData,String productCount) async {
    String cartJson = '{"user_id" : $userId, "cart_data": $cartData,"prod_count":$productCount }';
    print(cartJson + "CartJson");
    Response response = await _apiclient.invokeAPI(
        _removeProductFromCartPath+ "?user_id=$userId&cart_data=$cartData&prod_count=$productCount", 'POST_', {} );
    print(response);
    return Cart.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Cart>> getCartDetails(var userId) async {
    List<Cart> cartItems = [];
    int uid = int.parse(userId);
    Response response = await _apiclient
        .invokeAPI('$_getCartDetailsPath?user_id=$uid', 'GET', {});
    print("ResponseBody" + response.body);
    jsonDecode(response.body)['data'].forEach((element) {
      var item = Cart.fromJson(element);
      print(item);
      cartItems.add(item);
    });
    return cartItems;
  }
}
