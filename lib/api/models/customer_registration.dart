class CustomerRegistration{
  int? customerId;
  String? customerName;
  String? customerType;
  String? customerEmail;
  String? customerMobile;
  int? status;
  String? password;
  String? customerPincode;
  String? customerDistrict;
  String? customerState;
  String? customerAddress;
  String? remarks;

  CustomerRegistration();
  @override
  String toString() {
    return toJson().toString();
  }

  CustomerRegistration.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    customerId = json['customer_id'] == null ? null : json['customer_id'];
    customerName = json['customer_name'] == null ? null : json['customer_name'];
    customerType = json['customer_type'] == null ? null : json['customer_type'];
    customerEmail = json['customer_email'] == null ? null : json['customer_email'];
    customerMobile = json['customer_mobile'] == null ? null : json['customer_mobile'];
    status = json['status'] == null ? null : json['status'];
    password = json['password'] == null ? null : json['password'];
    customerPincode = json['customer_pincode'] == null ? null : json['customer_pincode'];
    customerDistrict = json['customer_dist'] == null ? null : json['customer_dist'];
    customerState = json['customer_state'] == null ? null : json['customer_state'];
    customerAddress = json['customer_address'] == null ? null : json['customer_address'];
    remarks = json['remarks'] == null ? null : json['remarks'];
    }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (customerId != null) json['customer_id'] = customerId;
    if (customerName != null) json['customer_name'] = customerName;
    if (customerType != null) json['customer_type'] = customerType;
    if (customerEmail != null) json['customer_email'] = customerEmail;
    if (customerMobile != null) json['customer_mobile'] = customerMobile;
    if (status != null) json['status'] = status;
    if (password != null) json['password'] = password;
    if (customerPincode != null) json['customer_pincode'] = customerPincode;
    if (customerDistrict != null) json['customer_dist'] = customerDistrict;
    if (customerState != null) json['customer_state'] = customerState;
    if (customerAddress != null) json['customer_address'] = customerAddress;
    if (remarks != null) json['remarks'] = customerAddress;
    return json;
  }

  static List<CustomerRegistration> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => CustomerRegistration.fromJson(value)).toList();
  }

}