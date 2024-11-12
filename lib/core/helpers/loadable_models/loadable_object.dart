import 'package:base_structure/core/data/network/api_response.dart';

class LoadableObject<T> {
  bool isLoading = false;
  ApiResponse<T>? data;
  T? get result => data?.data;
  LoadableObject({this.data});
}
