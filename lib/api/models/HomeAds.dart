class HomeAds {
  int? addId;
  String? page;
  String? image;
  String? url;
  String? createdAt;

  HomeAds({this.addId, this.page, this.image, this.url, this.createdAt});

 HomeAds.fromJson(Map<String, dynamic> json) {
    addId = json['add_id'];
    page = json['page'];
    image = json['image'];
    url = json['url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_id'] = this.addId;
    data['page'] = this.page;
    data['image'] = this.image;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    return data;
  }
  static List<HomeAds> listFromJson(List<dynamic>? json) {
    return json == null
        ?[]
        : json.map((value) => HomeAds.fromJson(value)).toList();
  }
}