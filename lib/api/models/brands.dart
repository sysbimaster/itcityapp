class Brands{
  String? brandId;
  String? brandsName;
  String? brandsNameArabic;
  String? brandImage;
  String? urlWorld;
  String? brandDescription;
  String? brandFor;
  String? adImage;
  String? bannerImage;
  String? offerText;
  String? subDescription;
  String? featured;

  Brands();
   @override
  String toString() {
    return toJson().toString();
  }

  Brands.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    brandId = json['brands_id'] == null ? null : json['brands_id'];
    brandsName = json['brands_name'] == null ? null : json['brands_name'];
    brandsNameArabic = json['brands_name_arabic'] == null ? null : json['brands_name_arabic'];
    brandImage = json['brand_image'] == null ? null : json['brand_image'];
    urlWorld = json['url_word'] == null ? null : json['url_word'];
    brandDescription = json['brand_description'] == null ? null : json['brand_description'];
    brandFor = json['brand_for'] == null ? null : json['brand_for'];
    adImage = json['ad_image'] == null ? null : json['ad_image'];
    bannerImage = json['banner_image'] == null ? null : json['banner_image'];
    offerText = json['offer_text'] == null ? null : json['offer_text'];
    subDescription = json['sub_desc'] == null ? null : json['sub_desc'];
    featured = json['featured'] == null ? null : json['featured'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(brandId !=null) json['brands_id']= brandId;
    if(brandsName !=null) json['brands_name']= brandsName;
    if(brandsNameArabic !=null) json['brands_name_arabic']= brandsNameArabic;
    if(brandImage !=null) json['brand_image']= brandImage;
    if(urlWorld  !=null) json['url_word ']= urlWorld ;
    if(brandDescription !=null) json['brand_description']= brandDescription;
    if(brandFor !=null) json['brand_for']= brandFor;
    if(adImage !=null) json['ad_image']= adImage;
    if(bannerImage !=null) json['banner_image']= bannerImage;
    if(offerText !=null) json['offer_text']= offerText;
    if(subDescription !=null) json['sub_desc']= subDescription;
    if(featured !=null) json['featured']= featured;
    return json;
  }
  static List<Brands> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => Brands.fromJson(value)).toList();
  }
}