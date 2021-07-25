class OrderDetails {
  int purchaseId;
  int customerId;
  Null orderId;
  Null customerType;
  String products;
  String productSubTotal;
  Null productPurchaseId;
  String purchaseDate;
  String country;
  String shippingCharge;

  OrderDetails(
      {this.purchaseId,
        this.customerId,
        this.orderId,
        this.customerType,
        this.products,
        this.productSubTotal,
        this.productPurchaseId,
        this.purchaseDate,
        this.country,
        this.shippingCharge});
  @override
  String toString() {
    return toJson().toString();
  }

 OrderDetails.fromJson(Map<String, dynamic> json) {
    purchaseId = json['purchase_id'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    customerType = json['customer_type'];
    products = json['products'];
    productSubTotal = json['product_sub_total'];
    productPurchaseId = json['product_purchase_id'];
    purchaseDate = json['purchase_date'];
    country = json['country'];
    shippingCharge = json['shipping_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_id'] = this.purchaseId;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['customer_type'] = this.customerType;
    data['products'] = this.products;
    data['product_sub_total'] = this.productSubTotal;
    data['product_purchase_id'] = this.productPurchaseId;
    data['purchase_date'] = this.purchaseDate;
    data['country'] = this.country;
    data['shipping_charge'] = this.shippingCharge;
    return data;
  }
  static List<OrderDetails> listFromJson(List<dynamic> json){
    return json == null
        ? List<OrderDetails>()
        : json.map((value) => OrderDetails.fromJson(value)).toList();
  }
}