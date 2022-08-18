class Tax{
  String? taxId;
  String? taxName;
  String? taxPercentage;

  Tax();
  @override
  String toString() {
    return toJson().toString();
  }

  Tax.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    taxId = json['tax_id'] == null ? null : json['tax_id'];
    taxName = json['tax_name'] == null ? null : json['tax_name'];
    taxPercentage = json['tax_percentage'] == null ? null : json['tax_percentage'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json ={};
    if(taxId !=null) json['tax_id']= taxId;
    if(taxName !=null) json['tax_name']= taxName;
    if(taxPercentage !=null) json['tax_percentage']= taxPercentage;
    return json;
  }
  static List<Tax> listFromJson(List<dynamic>? json){
    return json == null
    ? []
    : json.map((value) => Tax.fromJson(value)).toList();
  }
}