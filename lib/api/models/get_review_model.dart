/// data : [{"review_id":576,"author_name":"apptest1@gmail.com","product_id":"PRDCTF2392","text":"googd","rating":"5","review_status":0,"created_at":"2021-09-27 13:13:05","updated_at":"2021-09-27 13:13:05"},{"review_id":577,"author_name":"apptest1@gmail.com","product_id":"PRDCTF2392","text":"googd","rating":"5","review_status":0,"created_at":"2021-09-27 13:14:08","updated_at":"2021-09-27 13:14:08"},{"review_id":578,"author_name":"apptest1@gmail.com","product_id":"PRDCTF2392","text":"googd","rating":"5","review_status":0,"created_at":"2021-09-27 13:14:31","updated_at":"2021-09-27 13:14:31"},{"review_id":579,"author_name":"apptest1@gmail.com","product_id":"PRDCTF2392","text":"googd","rating":"5","review_status":0,"created_at":"2021-09-27 13:15:53","updated_at":"2021-09-27 13:15:53"}]
/// success : true
/// messages : []

class GetReviewModel {
  GetReviewModel({
      List<Data>? data, 
      bool? success, 
      List<dynamic>? messages,}){
    _data = data;
    _success = success;
    _messages = messages;
}

  GetReviewModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
       // _messages.add(dynamic.fromJson(v));
      });
    }
  }
  List<Data>? _data;
  bool? _success;
  List<dynamic>? _messages;

  List<Data>? get data => _data;
  bool? get success => _success;
  List<dynamic>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    if (_messages != null) {
      map['messages'] = _messages!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// review_id : 576
/// author_name : "apptest1@gmail.com"
/// product_id : "PRDCTF2392"
/// text : "googd"
/// rating : "5"
/// review_status : 0
/// created_at : "2021-09-27 13:13:05"
/// updated_at : "2021-09-27 13:13:05"

class Data {
  Data({
      int? reviewId, 
      String? authorName, 
      String? productId, 
      String? text, 
      String? rating, 
      int? reviewStatus, 
      String? createdAt, 
      String? updatedAt,}){
    _reviewId = reviewId;
    _authorName = authorName;
    _productId = productId;
    _text = text;
    _rating = rating;
    _reviewStatus = reviewStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _reviewId = json['review_id'];
    _authorName = json['author_name'];
    _productId = json['product_id'];
    _text = json['text'];
    _rating = json['rating'];
    _reviewStatus = json['review_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _reviewId;
  String? _authorName;
  String? _productId;
  String? _text;
  String? _rating;
  int? _reviewStatus;
  String? _createdAt;
  String? _updatedAt;

  int? get reviewId => _reviewId;
  String? get authorName => _authorName;
  String? get productId => _productId;
  String? get text => _text;
  String? get rating => _rating;
  int? get reviewStatus => _reviewStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review_id'] = _reviewId;
    map['author_name'] = _authorName;
    map['product_id'] = _productId;
    map['text'] = _text;
    map['rating'] = _rating;
    map['review_status'] = _reviewStatus;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}