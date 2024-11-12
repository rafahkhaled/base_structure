///A custom paginate list includes information about the data and current page
class PageListResult<T> {
  final List<T> data;
  final int currentPage;
  final int countPerPage;
  final int totalCount;
  bool get isNoMoreData => (currentPage * countPerPage) >= totalCount;

  PageListResult({
    List<T>? dateElements,
    this.currentPage = 0,
    this.countPerPage = 0,
    this.totalCount = 0,
  }) : data = dateElements ?? List.empty(growable: true);
}
