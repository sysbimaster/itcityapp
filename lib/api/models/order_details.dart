class OrderDetails {
  List<Data>? data;
  bool? success;
  List<Null>? messages;

  OrderDetails({this.data, this.success, this.messages});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    // if (json['messages'] != null) {
    //   messages = new List<Null>();
    //   json['messages'].forEach((v) {
    //     messages.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    // if (this.messages != null) {
    //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Data {
  int? purchaseId;
  int? customerId;
  Null orderId;
  Null customerType;
  String? products;
  String? productSubTotal;
  Null productPurchaseId;
  String? purchaseDate;
  String? country;
  String? shippingCharge;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
}