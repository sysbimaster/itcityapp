class Cart{
  int? cartId;
  String? userId;
  String? cartData;
  String? productId;
  String? productName;
  String? productNameArabic;
  String? productImage;
  String? productDesc;
  String? currency;

  double? productPrice;
  String? productDescArabic;
  int? productCount;
  Cart();
  @override
  String toString() {
    return toJson().toString();
  }

  Cart.fromJson(Map<String, dynamic> json) {
  print(json);
    if (json == null) return;
    cartId = json['cart_id'] == null ? null : json['cart_id'];
    userId = json['user_id'] == null ? null : json['user_id'];
    cartData = json['cart_data'] == null ? null : json['cart_data'];
    productName = json['product_name'] == null ? null : json['product_name'];
    productNameArabic = json['product_name_arabic'] == null ? null : json['product_name_arabic'];
    productDesc = json['product_desc'] == null ? null : json['product_desc'];
    productDescArabic = json['product_desc_arabic'] == null ? null : json['product_desc_arabic'];
    productCount = json['prod_count'] == null ? null : json['prod_count'];
    productPrice = json['prod_price'] == null ? null :double.parse( json['prod_price']);
    productImage = json['product_image'] == null ? null : json['product_image'];
    productId = json['product_id'] == null ? null : json['product_id'];
    currency  = json['cur'] == null ? null : json['cur'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(cartId !=null) json['cart_id']= cartId;
    if(userId !=null) json['user_id']= userId;
    if(cartData !=null) json['cart_data']= cartData;
    if(productName !=null) json['product_name']= productName;
    if(productNameArabic !=null) json['product_name_arabic']= productNameArabic;
    if(productDesc !=null) json['product_desc']= productDesc;
    if(productNameArabic !=null) json['product_desc_arabic']= productNameArabic;
    if(productCount !=null) json['prod_count']= productNameArabic;
    if(productPrice !=null) json['product_price']= productPrice;
    if(productImage !=null) json['product_image']= productImage;
    if(productId != null) json['product_id'] = productId;
    if(currency != null) json['cur'] = productId;
    return json;
  }
  static List<Cart> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => Cart.fromJson(value)).toList();
  }
}