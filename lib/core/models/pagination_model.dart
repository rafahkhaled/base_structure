class PaginationModel {
  int limit;
  int skip;

  PaginationModel({this.limit = 10, this.skip = 0});

  Map<String, dynamic> toMap() {
    return {
      'limit': limit,
      'skip': skip,
    };
  }
}