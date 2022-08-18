/// data : 580
/// success : true
/// messages : ["Data Inserterd"]

class PostReviewModel {
  PostReviewModel({
      int? data, 
      bool? success, 
      List<String>? messages,}){
    _data = data;
    _success = success;
    _messages = messages;
}

  PostReviewModel.fromJson(dynamic json) {
    _data = json['data'];
    _success = json['success'];
    _messages = json['messages'] != null ? json['messages'].cast<String>() : [];
  }
  int? _data;
  bool? _success;
  List<String>? _messages;

  int? get data => _data;
  bool? get success => _success;
  List<String>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['success'] = _success;
    map['messages'] = _messages;
    return map;
  }

}