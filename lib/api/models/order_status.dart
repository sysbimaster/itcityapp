class OrderStatus {
  int? data;
  bool? success;
  List<String>? messages;

  OrderStatus();
  @override
  String toString() {
    return toJson().toString();
  }
  OrderStatus.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    messages = json['messages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    data['messages'] = this.messages;
    return data;
  }

  static List<OrderStatus> listFromJson(List<dynamic> json){
    return json == null
    ? []
    : json.map((value) => OrderStatus.fromJson(value)).toList();
  }
}