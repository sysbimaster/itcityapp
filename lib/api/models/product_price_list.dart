class ProductPriceList{
  String? priceId;
  String? productId;
  String? normalPrice;
  String? offerPrice;
  String? taxPercentage;
  String? minQuantity;

  ProductPriceList();
  @override
  String toString() {
    return toJson().toString();
  }

  ProductPriceList.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    priceId = json['price_id'] == null ? null : json['price_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    normalPrice = json['normal_price'] == null ? null : json['normal_price'];
    offerPrice = json['offer_price'] == null ? null : json['offer_price'];
    taxPercentage = json['tax_percentage'] == null ? null : json['tax_percentage'];
    minQuantity = json['min_qty'] == null ? null : json['min_qty'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(priceId !=null) json['price_id']= priceId;
    if(productId !=null) json['product_id']= productId;
    if(normalPrice !=null) json['normal_price']= normalPrice;
    if(offerPrice !=null) json['offer_price']= offerPrice;
    if(taxPercentage  !=null) json['tax_percentage ']= taxPercentage ;
    if(minQuantity !=null) json['min_qty']= minQuantity;
    
   
    return json;
  }
  static List<ProductPriceList> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => ProductPriceList.fromJson(value)).toList();
  }

}