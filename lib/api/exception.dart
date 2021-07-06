class ApiException implements Exception{
  final statusCode;
  final message;
  ApiException({this.statusCode,this.message});
}