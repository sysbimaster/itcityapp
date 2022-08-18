class OrderStatusNew{
  int? orderId;
  Null orderNumber;
  int? customerId;
  int? purchaseId;
  Null customerGroupId;
  String? customerName;
  String? customerEmail;
  String? customerMob;
  String? paymentName;
  String? paymentAddress;
  String? paymentRegionId;
  Null paymentZoneId;
  Null paymentZoneName;
  String? paymentMethod;
  Null paymentCode;
  String? shippingAddress;
  String? shippingName;
  String? shippingRegionId;
  String? shippingZoneId;
  Null shippingMethod;
  String? orderStatusId;
  String? totalAmnt;
  Null ipAddress;
  Null userAgent;
  String? remarks;
  String? createdAt;
  Null updatedAt;

OrderStatusNew();
  @override
  String toString() {
    return toJson().toString();
  }
  OrderStatusNew.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    customerId = json['customer_id'];
    purchaseId = json['purchase_id'];
    customerGroupId = json['customer_group_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerMob = json['customer_mob'];
    paymentName = json['payment_name'];
    paymentAddress = json['payment_address'];
    paymentRegionId = json['payment_region_id'];
    paymentZoneId = json['payment_zone_id'];
    paymentZoneName = json['payment_zone_name'];
    paymentMethod = json['payment_method'];
    paymentCode = json['payment_code'];
    shippingAddress = json['shipping_address'];
    shippingName = json['shipping_name'];
    shippingRegionId = json['shipping_region_id'];
    shippingZoneId = json['shipping_zone_id'];
    shippingMethod = json['shipping_method'];
    orderStatusId = json['order_status_id'];
    totalAmnt = json['total_amnt'];
    ipAddress = json['ip_address'];
    userAgent = json['user_agent'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['customer_id'] = this.customerId;
    data['purchase_id'] = this.purchaseId;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_mob'] = this.customerMob;
    data['payment_name'] = this.paymentName;
    data['payment_address'] = this.paymentAddress;
    data['payment_region_id'] = this.paymentRegionId;
    data['payment_zone_id'] = this.paymentZoneId;
    data['payment_zone_name'] = this.paymentZoneName;
    data['payment_method'] = this.paymentMethod;
    data['payment_code'] = this.paymentCode;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_name'] = this.shippingName;
    data['shipping_region_id'] = this.shippingRegionId;
    data['shipping_zone_id'] = this.shippingZoneId;
    data['shipping_method'] = this.shippingMethod;
    data['order_status_id'] = this.orderStatusId;
    data['total_amnt'] = this.totalAmnt;
    data['ip_address'] = this.ipAddress;
    data['user_agent'] = this.userAgent;
    data['remarks'] = this.remarks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  static List<OrderStatusNew> listFromJson(List<dynamic> json){
    return json == null
        ? []
        : json.map((value) => OrderStatusNew.fromJson(value)).toList();
  }
}