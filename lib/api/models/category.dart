class Category {
  int? categoryId;
  int? parentId;
  int? sortOrder;
  String? categoryFor;
  String? categoryName;
  String? categoryNameArabic;
  String? categoryDescription;
  String? metaTagTitle;
  String? metaTagDescription;
  String? metaTagKeywords;
  String? categoryImage;
  int? status;

  Category();
  @override
  String toString() {
    return toJson().toString();
  }

  Category.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    categoryId = json['cat_id'] == null ? null : json['cat_id'];
    parentId = json['parent_id'] == null ? null : json['parent_id'];
    sortOrder = json['sort_order'] == null ? null : json['sort_order'];
    categoryFor = json['category_for'] == null ? null : json['category_for'];
    categoryName = json['cat_name'] == null ? null : json['cat_name'];
    categoryNameArabic =
        json['cat_name_arabic'] == null ? null : json['cat_name_arabic'];
    categoryDescription = json['cat_desc'] == null ? null : json['cat_desc'];
    metaTagTitle =
        json['meta_tag_title'] == null ? null : json['meta_tag_title'];
    metaTagDescription =
        json['meta_tag_desc'] == null ? null : json['meta_tag_desc'];
    metaTagKeywords =
        json['meta_tag_keywords'] == null ? null : json['meta_tag_keywords'];
    categoryImage = json['app_image'] == null ? null : json['app_image'];
    status = json['status'] == null ? null : json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (categoryId != null) json['cat_id'] = categoryId;
    if (parentId != null) json['parent_id'] = parentId;
    if (sortOrder != null) json['sort_order'] = sortOrder;
    if (categoryFor != null) json['category_for'] = categoryFor;
    if (categoryName != null) json['cat_name'] = categoryName;
    if (categoryNameArabic != null)
      json['cat_name_arabic'] = categoryNameArabic;
    if (categoryDescription != null) json['cat_desc'] = categoryDescription;
    if (metaTagTitle != null) json['meta_tag_title'] = metaTagTitle;
    if (metaTagDescription != null) json['meta_tag_desc'] = metaTagDescription;
    if (metaTagKeywords != null) json['meta_tag_keywords'] = metaTagKeywords;
    if (categoryImage != null) json['app_image'] = categoryImage;
    if (status != null) json['status'] = status;
    return json;
  }

  static List<Category> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => Category.fromJson(value)).toList();
  }
}
