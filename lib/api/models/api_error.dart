class ApiError {
  String? _error;

  ApiError({String? error}) {
    this._error = error;
  }

  String? get errors => _error;

  set error(String? errorval) => _error = errorval;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    return data;
  }
}