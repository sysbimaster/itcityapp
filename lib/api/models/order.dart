class Order{
  int? orderId;
  String? orderNumber;
  int? customerId;
  int? purchaseId;
  int? customerGroupId;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  String? paymentName;
  String? paymentAddress;
  String? paymentRegionId;
  String? paymentZoneId;
  String? paymentZoneName;
  String? paymentMethod;
  String? paymentCode;
  String? shippingAddress;
  String? shippingName;
  String? shippingRegionId;
  String? shippingZoneId;
  String? shippingMethod;
  String? orderStatusId;
  String? totalAmount;
  String? ipAddress;
  String? userAgent;
  String? remarks;
  String? currency;

  Order();
   @override
  String toString() {
    return toJson().toString();
  }

  Order.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    orderId = json['order_id'] == null ? null : json['order_id'];
    orderNumber = json['order_number'] == null ? null : json['order_number'];
    customerId = json['customer_id'] == null ? null : json['customer_id'];
    purchaseId = json['purchase_id'] == null ? null : json['purchase_id'];
    customerGroupId = json['customer_group_id'] == null ? null : json['customer_group_id'];
    customerName = json['customer_name'] == null ? null : json['customer_name'];
    customerEmail = json['customer_email'] == null ? null : json['customer_email'];
    customerMobile = json['customer_mob'] == null ? null : json['customer_mob'];
    paymentName = json['payment_name'] == null ? null : json['payment_name'];
    paymentAddress = json['payment_address'] == null ? null : json['payment_address'];
    paymentRegionId = json['payment_region_id'] == null ? null : json['payment_region_id'];
    paymentZoneId = json['payment_zone_id'] == null ? null : json['payment_zone_id'];
    paymentZoneName = json['payment_zone_name'] == null ? null : json['payment_zone_name'];
    paymentMethod = json['payment_method'] == null ? null : json['payment_method'];
    paymentCode = json['payment_code'] == null ? null : json['payment_code'];
    shippingAddress = json['shipping_address'] == null ? null : json['shipping_address'];
    shippingName = json['shipping_name'] == null ? null : json['shipping_name'];
    shippingRegionId = json['shipping_region_id'] == null ? null : json['shipping_region_id'];
    shippingZoneId = json['shipping_zone_id'] == null ? null : json['shipping_zone_id'];
    shippingMethod = json['shipping_method'] == null ? null : json['shipping_method'];
    orderStatusId = json['order_status_id'] == null ? null : json['order_status_id'];
    totalAmount = json['total_amnt'] == null ? null : json['total_amnt'];
    ipAddress = json['ip_address'] == null ? null : json['ip_address'];
    userAgent = json['user_agent'] == null ? null : json['user_agent'];
    remarks = json['remarks'] == null ? null : json['remarks'];
    currency = json['cur'] == null ? null : json['cur'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(orderId !=null) json['order_id']= orderId;
    if(orderNumber !=null) json['order_number']= orderNumber;
    if(customerId !=null) json['customer_id']= customerId;
    if(purchaseId !=null) json['purchase_id']= purchaseId;
    if(customerGroupId  !=null) json['customer_group_id ']= customerGroupId ;
    if(customerName !=null) json['customer_name']= customerName;
    if(customerEmail !=null) json['customer_email']= customerEmail;
    if(customerMobile !=null) json['customer_mob']= customerMobile;
    if(paymentName !=null) json['payment_name']= paymentName;
    if(paymentAddress !=null) json['payment_address']= paymentAddress;
    if(paymentRegionId !=null) json['payment_region_id']= paymentRegionId;
    if(paymentZoneId !=null) json['payment_zone_id']= paymentZoneId;
    if(paymentZoneName !=null) json['payment_zone_name']= paymentZoneName;
    if(paymentMethod !=null) json['payment_method']= paymentMethod;
    if(paymentCode !=null) json['payment_code']= paymentCode;
    if(shippingAddress !=null) json['shipping_address']= shippingAddress;
    if(shippingName !=null) json['shipping_name']= shippingName;
    if(shippingRegionId !=null) json['shipping_region_id']= shippingRegionId;
    if(shippingZoneId !=null) json['shipping_zone_id']= shippingZoneId;
    if(shippingMethod !=null) json['shipping_method']= shippingMethod;
     if(orderStatusId !=null) json['order_status_id']= orderStatusId;
    if(totalAmount !=null) json['total_amnt']= totalAmount;
    if(ipAddress !=null) json['ip_address']= ipAddress;
    if(userAgent !=null) json['user_agent']= userAgent;
    if(remarks  !=null) json['remarks ']= remarks ;
    if(currency  !=null) json['cur ']= currency ;
    return json;
  }
  static List<Order> listFromJson(List<dynamic> json){
    return json == null
    ? []
    : json.map((value) => Order.fromJson(value)).toList();
  }
}