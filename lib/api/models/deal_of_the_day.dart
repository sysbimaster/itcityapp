class DealOfTheDay {
  int? dealId;
  String? productId;
  String? startDate;
  String? endDate;
  String? amountDiscount;
  int? id;
  int? sortOrder;
  String? categoryId;
  String? productSlug;
  String? productName;
  String? productNameArabic;
  String? productBrand;
  String? productImage;
  String? productDesc;
  String? productDescArabic;
  var productPrice;
  var productPriceConvert;
  String? productPriceArabic;
  int? productQty;
  int? minPurQty;
  var productPriceOffer;
  var productPriceOfferConvert;
  String? productPriceOfferArabic;
  int? status;

  DealOfTheDay();
  @override
  String toString() {
    return toJson().toString();
  }

  DealOfTheDay.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    dealId = json['deal_id'] == null ? null : json['deal_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    startDate = json['start_date'] == null ? null : json['start_date'];
    endDate = json['end_date'] == null ? null : json['end_date'];
    amountDiscount =
        json['amount_discount'] == null ? null : json['amount_discount'];
    id = json['id'] == null ? null : json['id'];
    sortOrder = json['sort_order'] == null ? null : json['sort_order'];
    categoryId = json['category_id'] == null ? null : json['category_id'];
    productSlug = json['product_slug'] == null ? null : json['product_slug'];
    productName = json['product_name'] == null ? null : json['product_name'];
    productNameArabic = json['product_name_arabic'] == null
        ? null
        : json['product_name_arabic'];
    productBrand = json['product_brand'] == null ? null : json['product_brand'];
    productImage = json['product_image'] == null ? null : json['product_image'];
    productDesc = json['product_desc'] == null ? null : json['product_desc'];
    productDescArabic = json['product_desc_arabic'] == null
        ? null
        : json['product_desc_arabic'];
    productPrice = json['product_price'] == null ? null : json['product_price'];
    productPriceConvert = json['product_price_convert'] == null ? null : json['product_price_convert'];
    productPriceArabic = json['product_price_arabic'] == null
        ? null
        : json['product_price_arabic'];
    productQty = json['product_qty'] == null ? null : json['product_qty'];
    minPurQty = json['min_pur_qty'] == null ? null : json['min_pur_qty'];
    productPriceOffer = json['product_price_offer'] == null
        ? null
        : json['product_price_offer'];
    productPriceOfferConvert = json['product_price_offer_convert'] == null
        ? null
        : json['product_price_offer_convert'];
    productPriceOfferArabic = json['product_price_offer_arabic'] == null
        ? null
        : json['product_price_offer_arabic'];
    status = json['status'] == null ? null : json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (dealId != null) json['deal_id'] = dealId;
    if (productId != null) json['product_id'] = productId;
    if (startDate != null) json['start_date'] = startDate;
    if (endDate != null) json['end_date'] = endDate;
    if (amountDiscount != null) json['amount_discount '] = amountDiscount;
    if (id != null) json['id'] = id;
    
    if (sortOrder != null) json['sort_order'] = sortOrder;
    if (categoryId != null) json['category_id'] = categoryId;
    if (productSlug != null) json['product_slug'] = productSlug;
    if (productName != null) json['product_name'] = productName;
    if (productNameArabic != null)
      json['product_name_arabic'] = productNameArabic;
    if (productBrand != null) json['product_brand'] = productBrand;
    if (productImage != null) json['product_image'] = productImage;
    if (productDesc != null) json['product_desc'] = productDesc;
    if (productDescArabic != null)
      json['_product_desc_arabic'] = productDescArabic;
    if (productPrice != null) json['product_price'] = productPrice;
    if (productPriceConvert != null) json['product_price_convert'] = productPriceConvert;
    if (productPriceArabic != null)
      json['product_price_arabic'] = productPriceArabic;
    if (productQty != null) json['product_qty'] = productQty;
    if (minPurQty != null) json['min_pur_qty'] = minPurQty;
    if (productPriceOfferConvert != null)
      json['product_price_offer_convert'] = productPriceOfferConvert;
    if (productPriceOfferArabic != null)
      json['product_price_offer_arabic'] = productPriceOfferArabic;
    if (status != null) json['status'] = status;

    return json;
  }

  static List<DealOfTheDay> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => DealOfTheDay.fromJson(value)).toList();
  }
}
