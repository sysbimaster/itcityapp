class Wishlist{
  int? wishlistId;
  String? username;
  String? wishlist;

  Wishlist();
  @override
  String toString() {
    return toJson().toString();
  }

  Wishlist.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    wishlistId = json['whishlist_id'] == null ? null : json['whishlist_id'];
    username = json['username'] == null ? null : json['username'];
    wishlist = json['wishlist'] == null ? null : json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(wishlistId !=null) json['whishlist_id']= wishlistId;
    if(username !=null) json['username']= username;
    if(wishlist !=null) json['wishlist']= wishlist;
    return json;
  }
  static List<Wishlist> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => Wishlist.fromJson(value)).toList();
  }
}