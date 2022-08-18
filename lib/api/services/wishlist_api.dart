import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart';

class WishlistApi {
  ApiClient _apiclient = ApiClient();
  String _wishlistPath = '/getWishlistByUsername';
  String _moveProductFromWishlistToCartPath = '';
  String _moveAllProductFromWishlistToCartPath = '';
  String _removeAllProductFromWishlistPath = '';
  String _removeProductFromWishlistPath = '/removeProductFromWishlistByProductId';
  String _addProductToWishlistPath = '/createWishlist';

  Future<List<CustomerWishlist>> fetchWishlist(String? username,String? currency) async {
    Response response = await _apiclient.invokeAPI('$_wishlistPath?username=$username&cur=$currency', 'GET', null);
    return CustomerWishlist.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Cart>> moveProductFromWishlistToCart(var productId) async {
    Wishlist wishlist = Wishlist();
    wishlist.wishlist = productId;
    Response response = await _apiclient.invokeAPI(
        _moveProductFromWishlistToCartPath, 'POST', wishlist.toJson());
    return Cart.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Cart>> moveAllProductFromWishlistToCart(var wishlistId) async {
    Wishlist wishlist = Wishlist();
    wishlist.wishlistId = wishlistId;
    Response response = await _apiclient.invokeAPI(
        _moveAllProductFromWishlistToCartPath, 'POST', wishlist.toJson());
    return Cart.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Wishlist>> removeAllProductFromWishlist(var wishlistId) async {
    Wishlist wishlist = Wishlist();
    wishlist.wishlistId = wishlistId;
    Response response = await _apiclient.invokeAPI(
        _removeAllProductFromWishlistPath, 'DELETE', wishlist.toJson());
    return Wishlist.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<String> removeProductFromWishlist(Wishlist wishlists) async {
    String jsonString ='{"username": "${wishlists.username}","wishlist": "${wishlists.wishlist}"}';
    Response response = await _apiclient.invokeAPI(
        _removeProductFromWishlistPath, 'POST', jsonString);
    
    return "removed";
  }

  Future<String> addProductToWishlist(Wishlist wish) async {
    String jsonString ='{"username": "${wish.username}","wishlist": "${wish.wishlist}"}';
    Response response = await _apiclient.invokeAPI(
        _addProductToWishlistPath, 'POST',jsonString);
    return "added";
  }
}
