class Currency {
  bool? success;
  String? terms;
  String? privacy;
  Query? query;
  Info? info;
  double? result;

  Currency(
      {this.success,
        this.terms,
        this.privacy,
        this.query,
        this.info,
        this.result});

  Currency.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    terms = json['terms'];
    privacy = json['privacy'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['result'] = this.result;
    return data;
  }
}

class Query {
  String? from;
  String? to;
  double? amount;

  Query({this.from, this.to, this.amount});

  Query.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['amount'] = this.amount;
    return data;
  }
}

class Info {
  int? timestamp;
  double? quote;

  Info({this.timestamp, this.quote});

  Info.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['quote'] = this.quote;
    return data;
  }
}