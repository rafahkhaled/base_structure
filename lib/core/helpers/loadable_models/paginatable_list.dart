import 'package:base_structure/core/helpers/loadable_models/loadable_list.dart';

class PaginatableList<T> extends LoadableList<T> {
  final int defaultCountPerPage;
  int currentPage = 0;
  int totalCount = 0;
  bool hasMore = true;

  PaginatableList({required this.defaultCountPerPage});

  @override
  void clear() {
    currentPage = 0;
    hasMore = true;
    super.clear();
  }

  void moveNext() {
    currentPage++;
  }

  @override
  void addRange(Iterable<T> elements) {
    hasMore = elements.length == defaultCountPerPage;
    super.addRange(elements);
  }
}
