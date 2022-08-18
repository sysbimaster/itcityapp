class Purchase {
  String? rowId;
  int? purchaseId;
  int? customerId;
  int? orderId;
  String? customerType;
  String? products;
  double? productSubTotal;
  int? productPurchaseId;
  String? purchaseDate;
  double? ShippingCharge;

  Purchase();
  @override
  String toString() {
    return toJson().toString();
  }

  Purchase.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    purchaseId = json['purchase_id'] == null
        ? null
        : json['purchase_id'];
    customerId = json['customer_id'] == null ? null : json['customer_id'];
    orderId = json['order_id'] == null ? null : json['order_id'];
    customerType =
        json['customer_type'] == null ? null : json['customer_type'];
    products = json['products'] == null ? null : json['products'];
    productSubTotal =
        json['product_sub_total'] == null ? null : double.parse(json['product_sub_total']);
    productPurchaseId =
        json['product_purchase_id'] == null ? null : json['product_purchase_id'];
    purchaseDate = json['purchase_date'] == null ? null : json['purchase_date'];
    ShippingCharge = json['shipping_charge'] == null ? null : double.parse(json['shipping_charge']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (purchaseId != null) json['purchase_id'] = purchaseId;
    if (customerId != null) json['customer_id'] = customerId;
    if (orderId != null) json['order_id'] = orderId;
    if (customerType != null) json['customer_type'] = customerType;
    if (products != null) json['products'] = products;
    if (productSubTotal != null) json['product_sub_total'] = productSubTotal;
    if (productPurchaseId != null) json['product_purchase_id'] = productPurchaseId;
    if (purchaseDate != null) json['purchase_date'] = purchaseDate;
    if (ShippingCharge != null) json['shipping_charge'] = ShippingCharge;
    return json;
  }

  static List<Purchase> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => Purchase.fromJson(value)).toList();
  }
}
