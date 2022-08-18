class WhatsappMobile {
  String? id;
  String? mobile;
  String? ip;

  WhatsappMobile();
  @override
  String toString() {
    return toJson().toString();
  }

  WhatsappMobile.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'] == null ? null : json['id'];
    mobile = json['mobile'] == null ? null : json['mobile'];
    ip = json['ip'] == null ? null : json['ip'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (mobile != null) json['mobile'] = mobile;
    if (ip != null) json['ip'] = ip;
    return json;
  }

  static List<WhatsappMobile> listFromJson(List<dynamic> json) {
    return json == null
        ?[]
        : json.map((value) => WhatsappMobile.fromJson(value)).toList();
  }
}
