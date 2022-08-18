class TodaysDeals {
  int? dealId;
  String? productId;
  String? startDate;
  String? endDate;
  String? amountDiscount;

  TodaysDeals();
  @override
  String toString() {
    return toJson().toString();
  }

  TodaysDeals.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    dealId = json['deal_id'] == null ? null : json['deal_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    startDate = json['start_date'] == null ? null : json['start_date'];
    endDate = json['end_date'] == null ? null : json['end_date'];
    amountDiscount =
        json['amount_discount'] == null ? null : json['amount_discount'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (dealId != null) json['deal_id'] = dealId;
    if (productId != null) json['product_id'] = productId;
    if (startDate != null) json['start_date'] = startDate;
    if (endDate != null) json['end_date'] = endDate;
    if (amountDiscount != null) json['amount_discount '] = amountDiscount;
    return json;
  }

  static List<TodaysDeals> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => TodaysDeals.fromJson(value)).toList();
  }
}
