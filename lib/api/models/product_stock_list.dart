class ProductStockList{
  String? stockId;
  String? productId;
  String? totalQuantity;
  String? remainingQuantity;
  String? addedDate;
  String? stockStatus;

  ProductStockList();
   @override
  String toString() {
    return toJson().toString();
  }

  ProductStockList.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stockId = json['stock_id'] == null ? null : json['stock_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    totalQuantity = json['total_qty'] == null ? null : json['total_qty'];
    remainingQuantity = json['remaining_qty'] == null ? null : json['remaining_qty'];
    addedDate = json['added_date'] == null ? null : json['added_date'];
    stockStatus = json['stock_status'] == null ? null : json['stock_status'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(stockId !=null) json['stock_id']= stockId;
    if(productId !=null) json['product_id']= productId;
    if(totalQuantity !=null) json['total_qty']= totalQuantity;
    if(remainingQuantity !=null) json['remaining_qty']= remainingQuantity;
    if(addedDate  !=null) json['added_date ']= addedDate ;
    if(stockStatus !=null) json['stock_status']= stockStatus;
    
   
    return json;
  }
  static List<ProductStockList> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => ProductStockList.fromJson(value)).toList();
  }

}