class SellOnItcity{
  String? sellId;
  String? sellName;
  String? sellCompanyName;
  String? sellMobile;
  String? sellProduct;
  String? sellEmail;
  

  SellOnItcity();
  @override
  String toString() {
    return toJson().toString();
  }

  SellOnItcity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    sellId = json['sell_id'] == null ? null : json['sell_id'];
    sellName = json['sell_name'] == null ? null : json['sell_name'];
    sellCompanyName = json['sell_company_name'] == null ? null : json['sell_company_name'];
    sellMobile = json['sell_mobile'] == null ? null : json['sell_mobile'];
    sellProduct = json['sell_product'] == null ? null : json['sell_product'];
    sellEmail = json['sell_email'] == null ? null : json['sell_email'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sellId != null) json['sell_id'] = sellId;
    if (sellName != null) json['sell_name'] = sellName;
    if (sellCompanyName != null) json['sell_company_name'] = sellCompanyName;
    if (sellMobile != null) json['sell_mobile'] = sellMobile;
    if (sellProduct != null) json['sell_product '] = sellProduct;
    if (sellEmail != null) json['sell_email'] = sellEmail;
    
    return json;
  }

  static List<SellOnItcity> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => SellOnItcity.fromJson(value)).toList();
  }

}