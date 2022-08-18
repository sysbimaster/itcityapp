class HomeImages {
  int? imageId;
  String? imageName;
  String? imageFor;
  String? url;

  HomeImages();
  @override
  String toString() {
    return toJson().toString();
  }

  HomeImages.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    imageId = json['img_id'] == null ? null : json['img_id'];
    imageName = json['img_name'] == null ? null : json['img_name'];
    imageFor = json['img_for'] == null ? null : json['img_for'];
    url = json['url'] == null ? null : json['url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (imageId != null) json['img_id'] = imageId;
    if (imageName != null) json['img_name'] = imageName;
    if (imageFor != null) json['img_for'] = imageFor;
    if (url != null) json['url'] = url;
    return json;
  }

  static List<HomeImages> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => HomeImages.fromJson(value)).toList();
  }
}
