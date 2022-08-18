class ProductOrderDetails {
  List<Data>? data;
  bool? success;
  List<Null>? messages;

  ProductOrderDetails({this.data, this.success, this.messages});

  ProductOrderDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =  [];
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
  String? id;
  String? name;
  int? qty;
  double? price;
  double? subtotal;

  Data({this.id, this.name, this.qty, this.price, this.subtotal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['subtotal'] = this.subtotal;
    return data;
  }
}