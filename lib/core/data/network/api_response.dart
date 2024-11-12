class ApiResponse<T> implements Exception {
  T? data;
  String msg;
  Exception? exception;

  ApiResponse({this.data, this.msg = "", this.exception});
}
