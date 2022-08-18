class PaymentMethod{
  String? paymentMethodId;
  String? paymentName;
  String? status;

  PaymentMethod();
  @override
  String toString() {
    return toJson().toString();
  }

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    paymentMethodId = json['payment_method_id'] == null ? null : json['payment_method_id'];
    paymentName = json['payment_name'] == null ? null : json['payment_name'];
    status = json['status'] == null ? null : json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(paymentMethodId !=null) json['payment_method_id']= paymentMethodId;
    if(paymentName !=null) json['payment_name']= paymentName;
    if(status !=null) json['status']= status;
    return json;
  }
  static List<PaymentMethod> listFromJson(List<dynamic> json){
    return json == null
    ? []
    : json.map((value) => PaymentMethod.fromJson(value)).toList();
  }
}