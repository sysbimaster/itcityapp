class Review{
  int? reviewId;
  String? authorName;
  String? productId;
  String? text;
  String? rating;
  int? reviewStatus;
  

  Review();
  @override
  String toString() {
    return toJson().toString();
  }

  Review.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reviewId = json['review_id'] == null ? null : json['review_id'];
    authorName = json['author_name'] == null ? null : json['author_name'];
    productId = json['product_id'] == null ? null : json['product_id'];
    text = json['text'] == null ? null : json['text'];
    rating = json['rating'] == null ? null : json['rating'];
    reviewStatus = json['review_status'] == null ? null : json['review_status'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (reviewId != null) json['review_id'] = reviewId;
    if (authorName != null) json['author_name'] = authorName;
    if (productId != null) json['product_id'] = productId;
    if (text != null) json['text'] = text;
    if (rating != null) json['rating '] = rating;
    if (reviewStatus != null) json['review_status'] = reviewStatus;
    
    return json;
  }

  static List<Review> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => Review.fromJson(value)).toList();
  }
}