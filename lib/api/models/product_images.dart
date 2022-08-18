class ProductImages{
  String? imageId;
  String? productId;
  String? images;

  ProductImages();
  @override
  String toString() {
    return toJson().toString();
  }

  ProductImages.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    imageId = json['image_id'] == null ? null : json['image_id'];
    productId = json['product_id'] == null ? null : json['product_id'];
    images = json['images'] == null ? null : json['images'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(imageId !=null) json['image_id']= imageId;
    if(productId !=null) json['product_id']= productId;
    if(images !=null) json['images']= images;
    return json;
  }
  static List<ProductImages> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => ProductImages.fromJson(value)).toList();
  }

}