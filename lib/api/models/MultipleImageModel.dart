/// data : [{"image_id":1,"product_id":"PRDCTF5076","images":"1645242642.jpg","created_at":"2022-02-19"},{"image_id":2,"product_id":"PRDCTF5076","images":"1645242642.jpg","created_at":"2022-02-19"},{"image_id":3,"product_id":"PRDCTF5076","images":"1645242642.jpg","created_at":"2022-02-19"},{"image_id":4,"product_id":"PRDCTF5076","images":"1645242642.jpg","created_at":"2022-02-19"}]
/// success : true
/// messages : []

class MultipleImageModel {
  MultipleImageModel({
      List<Data>? data,
      bool? success,
      List<dynamic>? messages,}){
    _data = data;
    _success = success;
    _messages = messages;
}

  MultipleImageModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _success = json['success'];

    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(json['messages']);
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
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image_id : 1
/// product_id : "PRDCTF5076"
/// images : "1645242642.jpg"
/// created_at : "2022-02-19"

class Data {
  Data({
      int? imageId,
      String? productId,
      String? images,
      String? createdAt,}){
    _imageId = imageId;
    _productId = productId;
    _images = images;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _imageId = json['image_id'];
    _productId = json['product_id'];
    _images = json['images'];
    _createdAt = json['created_at'];
  }
  int? _imageId;
  String? _productId;
  String? _images;
  String? _createdAt;

  int? get imageId => _imageId;
  String? get productId => _productId;
  String? get images => _images;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_id'] = _imageId;
    map['product_id'] = _productId;
    map['images'] = _images;
    map['created_at'] = _createdAt;
    return map;
  }

}