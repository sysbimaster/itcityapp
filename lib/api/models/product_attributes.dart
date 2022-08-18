class ProductAttributes{
  String? productsAttributesId;
  String? productId;
  String? attributeType;
  String? attributeValue;
  String? attributePrice;
  String? attributeImage;
  String? availableQuantity;

  ProductAttributes();
  @override
  String toString() {
    return toJson().toString();
  }

  ProductAttributes.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    productsAttributesId = json['products_attributes_id'] == null ? null : json['products_attributes_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    attributeType = json['attrbute_type'] == null ? null : json['attrbute_type'];
    attributeValue = json['attribute_value'] == null ? null : json['attribute_value'];
    attributePrice = json['attribute_price'] == null ? null : json['attribute_price'];
    attributeImage = json['attribute_image'] == null ? null : json['attribute_image'];
    availableQuantity = json['available_qty'] == null ? null : json['available_qty'];
   
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(productsAttributesId !=null) json['products_attributes_id']= productsAttributesId;
    if(productId !=null) json['product_id']= productId;
    if(attributeType !=null) json['attrbute_type']= attributeType;
    if(attributeValue !=null) json['attribute_value']= attributeValue;
    if(attributePrice  !=null) json['attribute_price ']= attributePrice ;
    if(attributeImage !=null) json['attribute_image']= attributeImage;
    if(availableQuantity !=null) json['available_qty']= availableQuantity;
   
    return json;
  }
  static List<ProductAttributes> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => ProductAttributes.fromJson(value)).toList();
  }
}